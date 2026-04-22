/* ----------------------------------------------------------------------------------
 * File Name       : MediHomesRelatedCasesController
 * Author          : Jeongyeon
 * Date            : 4/22/26
 * Test Class Name : N/A
 * Description     : 동일 Account 관련 케이스 목록 조회 컨트롤러
 *                   caseRelatedCases LWC에서 호출
 * Modification Log
 * ===================================================================================
 * Ver   Date      Author       Modification
 * ===================================================================================
   1.0   4/22/26   Jeongyeon   Create
 * --------------------------------------------------------------------------------- */
public with sharing class MediHomesRelatedCasesController {

    @AuraEnabled(cacheable=true)
    public static List<CaseInfo> getRelatedCases(Id caseId) {
        List<CaseInfo> result = new List<CaseInfo>();

        List<Case> current = [SELECT AccountId FROM Case WHERE Id = :caseId LIMIT 1];
        if (current.isEmpty() || current[0].AccountId == null) return result;

        Id accountId = current[0].AccountId;

        List<Case> cases = [
            SELECT Id, CaseNumber, Subject, Status, CreatedDate
            FROM   Case
            WHERE  AccountId = :accountId
            AND    Id        != :caseId
            ORDER BY CreatedDate ASC
            LIMIT  10
        ];

        for (Case c : cases) {
            CaseInfo info   = new CaseInfo();
            info.caseId     = c.Id;
            info.caseNumber = c.CaseNumber;
            info.subject    = String.isNotBlank(c.Subject) ? c.Subject : '(제목 없음)';
            info.status     = c.Status;
            result.add(info);
        }
        return result;
    }

    public class CaseInfo {
        @AuraEnabled public String caseId;
        @AuraEnabled public String caseNumber;
        @AuraEnabled public String subject;
        @AuraEnabled public String status;
    }
}
