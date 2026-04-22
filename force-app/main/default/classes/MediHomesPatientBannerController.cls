/* ----------------------------------------------------------------------------------
 * File Name       : MediHomesPatientBannerController
 * Author          : Jeongyeon
 * Date            : 4/22/26
 * Test Class Name : N/A
 * Description     : Case → 환자(Personal Account) 정보 조회 컨트롤러
 *                   agentDailyBanner LWC에서 호출
 * Modification Log
 * ===================================================================================
 * Ver   Date      Author       Modification
 * ===================================================================================
   1.0   4/22/26   Jeongyeon   Create
 * --------------------------------------------------------------------------------- */
public with sharing class MediHomesPatientBannerController {

    @AuraEnabled(cacheable=true)
    public static Map<String, Object> getPatientInfo(Id caseId) {
        List<Case> cases = [
            SELECT AccountId,
                   Account.Name,
                   Account.PatientStatus__pc,
                   Account.InsuranceType__pc
            FROM   Case
            WHERE  Id = :caseId
            LIMIT  1
        ];

        if (cases.isEmpty() || cases[0].AccountId == null) {
            return new Map<String, Object>();
        }

        Case c = cases[0];
        Map<String, Object> result = new Map<String, Object>();
        result.put('patientName',    c.Account.Name);
        result.put('patientStatus',  c.Account.PatientStatus__pc);
        result.put('insuranceType',  c.Account.InsuranceType__pc);
        return result;
    }
}
