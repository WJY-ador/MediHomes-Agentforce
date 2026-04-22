public without sharing class MediHomesOTPSender {

    public class OTPInput {
        @InvocableVariable(required=true)
        public String email;
    }

    public class OTPResult {
        @InvocableVariable public Boolean success;
        @InvocableVariable public String otpCode;
        @InvocableVariable public String message;
    }

    @InvocableMethod(
        label='OTP 생성 및 이메일 발송'
        description='6자리 OTP를 생성하고 Apex Messaging API로 이메일을 발송합니다.'
    )
    public static List<OTPResult> sendOTP(List<OTPInput> inputs) {
        List<OTPResult> results = new List<OTPResult>();

        for (OTPInput input : inputs) {
            OTPResult result = new OTPResult();

            try {
                Integer otp = Math.abs(Math.mod(Crypto.getRandomInteger(), 900000)) + 100000;
                String otpCode = String.valueOf(otp);

                String body = '안녕하세요, 메디홈즈입니다.\n\n'
                    + '본인 확인을 위한 인증 코드를 안내드립니다.\n\n'
                    + '인증 코드: ' + otpCode + '\n\n'
                    + '이 코드는 10분간 유효합니다.\n'
                    + '본인이 요청하지 않은 경우 이 메시지를 무시해 주세요.\n\n'
                    + '감사합니다.\n메디홈즈 고객 서비스팀';

                List<OrgWideEmailAddress> owea = [
                    SELECT Id FROM OrgWideEmailAddress
                    LIMIT 1
                ];

                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                mail.setToAddresses(new List<String>{ input.email });
                mail.setSubject('[메디홈즈] 본인 인증 코드');
                mail.setPlainTextBody(body);
                mail.setSaveAsActivity(false);
                if (!owea.isEmpty()) {
                    mail.setOrgWideEmailAddressId(owea[0].Id);
                }

                Messaging.SendEmailResult[] sendResults = Messaging.sendEmail(
                    new List<Messaging.SingleEmailMessage>{ mail }
                );

                if (sendResults[0].isSuccess()) {
                    result.success = true;
                    result.otpCode = otpCode;
                    result.message = '인증 코드가 발송되었습니다. 이메일을 확인해주세요.';
                } else {
                    result.success = false;
                    result.otpCode = otpCode;
                    result.message = '이메일 발송에 실패했습니다: ' + sendResults[0].getErrors()[0].getMessage();
                }

            } catch (Exception e) {
                result.success = false;
                result.message = '오류가 발생했습니다: ' + e.getMessage();
            }

            results.add(result);
        }

        return results;
    }
}