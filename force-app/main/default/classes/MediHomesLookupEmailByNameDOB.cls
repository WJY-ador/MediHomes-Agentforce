public without sharing class MediHomesLookupEmailByNameDOB {

    public class LookupInput {
        @InvocableVariable(required=true)
        public String name;
        @InvocableVariable(required=true)
        public String dateOfBirth;
    }

    public class LookupResult {
        @InvocableVariable public Boolean found;
        @InvocableVariable public String email;
        @InvocableVariable public String maskedEmail;
        @InvocableVariable public String phone;
        @InvocableVariable public String maskedPhone;
    }

    @InvocableMethod(
        label='이름/생년월일로 이메일 조회'
        description='성함과 생년월일로 고객의 이메일을 조회하고 마스킹하여 반환합니다.'
    )
    public static List<LookupResult> lookupEmail(List<LookupInput> inputs) {
        List<LookupResult> results = new List<LookupResult>();

        for (LookupInput input : inputs) {
            LookupResult result = new LookupResult();
            Date dob;
            try {
                dob = Date.valueOf(input.dateOfBirth);
                System.debug('Parsed DOB: ' + dob);
            } catch (Exception e) {
                result.found = false;
                results.add(result);
                continue;
            }

            String normalizedInput = input.name.trim().replaceAll('\\s+', '');

            List<Account> candidates = [
                SELECT PersonEmail, Name, Phone
                FROM Account
                WHERE Birthdate__pc = :dob
                AND IsPersonAccount = true
            ];

            Account matched = null;
            for (Account acc : candidates) {
                if (acc.Name.replaceAll('\\s+', '') == normalizedInput) {
                    matched = acc;
                    break;
                }
            }

            if (matched == null || String.isBlank(matched.PersonEmail)) {
                result.found = false;
            } else {
                result.found = true;
                result.email = matched.PersonEmail;
                result.maskedEmail = maskEmail(matched.PersonEmail);
                result.phone = matched.Phone;
                result.maskedPhone = maskPhone(matched.Phone);
            }

            results.add(result);
        }

        return results;
    }

    private static String maskEmail(String email) {
        Integer atIndex = email.indexOf('@');
        if (atIndex < 2) {
            return '***@' + email.substring(atIndex + 1);
        }
        return email.substring(0, 2) + '***@' + email.substring(atIndex + 1);
    }

    private static String maskPhone(String phone) {
        if (String.isBlank(phone)) return '';
        String digits = phone.replaceAll('[^0-9]', '');
        if (digits.length() == 11) {
            return digits.substring(0, 3) + '-****-' + digits.substring(7);
        } else if (digits.length() == 10) {
            return digits.substring(0, 3) + '-***-' + digits.substring(7);
        }
        return phone;
    }
}