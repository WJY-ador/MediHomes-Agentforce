// 더미 케이스 100건 생성
// Origin: Ai Chat / 상담사 이관
// Status: Closed(70), Escalated(10), New(10), Working(10)

// ── 환자 Account IDs ──────────────────────────────
List<Id> patientIds = new List<Id>{
    '001Ig00000EVfxUIAT',  // 원정연
    '001Ig00000EVa1tIAD',  // 박태원
    '001Ig00000EVa1yIAD'   // 김민준
};

// ── Asset IDs (Case.AssetId 연결용) ──────────────
// CPAP 4개 / 마스크 4개 / 소모품 2개
List<Id> cpapAssets = new List<Id>{
    '02iIg000000tVktIAE',  // 레즈메드 에어센스10 오토셋
    '02iIg000000tVkuIAE',  // 필립스 드림스테이션 오토셋
    '02iIg000000tVkvIAE',  // 레즈메드 에어미니 오토셋
    '02iIg000000tVkwIAE'   // BMC M1 미니 오토셋
};
List<Id> maskAssets = new List<Id>{
    '02iIg000000tVkxIAE',  // 레즈메드 에어핏 N30i
    '02iIg000000tVkyIAE',  // 레즈메드 에어핏 N20
    '02iIg000000tVkzIAE',  // 레즈메드 에어핏 P30i
    '02iIg000000tVl0IAE'   // 레즈메드 에어핏 P10
};
List<Id> supplyAssets = new List<Id>{
    '02iIg000000tVl1IAE',  // 레즈메드 S10 열선 호스
    '02iIg000000tVl2IAE'   // 레즈메드 에어미니 N20 셋업팩
};

// ── 피클리스트 값 ─────────────────────────────────
List<String> productCategories = new List<String>{
    'ResMed AirSense 11','ResMed AirSense 11','ResMed AirSense 11',  // 35%
    'Philips DreamStation 2','Philips DreamStation 2','Philips DreamStation 2',  // 30%
    '마스크','마스크',                                                 // 20%
    '소모품·필터',                                                     // 10%
    '기타'                                                             // 5%
};
List<String> inquiryTypes = new List<String>{
    '사용방법','사용방법','사용방법','사용방법',  // 25%
    '오류·고장','오류·고장','오류·고장',          // 20%
    '교체·구매','교체·구매','교체·구매',          // 20%
    '계약·렌탈','계약·렌탈',                      // 15%
    '보험·청구',                                  // 10%
    '점검 요청',                                  // 5%
    '기타'                                        // 5%
};
List<String> sentiments = new List<String>{
    '긍정','긍정','긍정',   // 30%
    '보통','보통','보통',   // 30%
    '부정','부정','부정',   // 25%  (합계 맞추기용 반복)
    '알수없음','알수없음'   // 15%
};

// ── Case 분포 정의 ─────────────────────────────────
// 총 100건
// Closed + Ai Chat     : 70건
// Escalated + 상담사이관: 10건
// New + Ai Chat        : 10건
// Working + Ai Chat    : 10건

List<Case> cases = new List<Case>();
Integer idx = 0;

// 헬퍼: 인덱스 기반 순환 선택
// (랜덤 대신 균등 분포를 위해 mod 사용)
for (Integer i = 0; i < 100; i++) {
    Case c = new Case();

    // Status / Origin 분배
    if      (i < 70)  { c.Status = 'Closed';    c.Origin = 'Ai Chat';    }
    else if (i < 80)  { c.Status = 'Escalated'; c.Origin = '상담사 이관'; }
    else if (i < 90)  { c.Status = 'New';       c.Origin = 'Ai Chat';    }
    else              { c.Status = 'Working';    c.Origin = 'Ai Chat';    }

    // AccountId (환자 순환)
    c.AccountId = patientIds[Math.mod(i, 3)];

    // Subject
    c.Subject = '[메디홈즈] ' + inquiryTypes[Math.mod(i, inquiryTypes.size())] + ' 문의';

    // ProductCategory__c
    c.ProductCategory__c = productCategories[Math.mod(i, productCategories.size())];

    // InquiryType__c
    c.InquiryType__c = inquiryTypes[Math.mod(i, inquiryTypes.size())];

    // AssetId — 제품 카테고리에 맞게 연결
    String cat = c.ProductCategory__c;
    if (cat == 'ResMed AirSense 11' || cat == 'Philips DreamStation 2') {
        c.AssetId = cpapAssets[Math.mod(i, cpapAssets.size())];
    } else if (cat == '마스크') {
        c.AssetId = maskAssets[Math.mod(i, maskAssets.size())];
    } else if (cat == '소모품·필터') {
        c.AssetId = supplyAssets[Math.mod(i, supplyAssets.size())];
    }
    // 기타는 AssetId null

    // CustomerSentiment__c — 피클리스트 캐시 이슈로 insert 후 별도 update 처리

    // CSAT__c — Closed 케이스만
    if (c.Status == 'Closed') {
        // 5:35%, 4:35%, 3:20%, 2:5%, 1:5% → mod 20 기준
        Integer r = Math.mod(i, 20);
        if      (r < 6)  c.CSAT__c = 5;
        else if (r < 13) c.CSAT__c = 4;
        else if (r < 17) c.CSAT__c = 3;
        else if (r < 19) c.CSAT__c = 2;
        else             c.CSAT__c = 1;
    }

    cases.add(c);
}

insert cases;
System.debug('Cases inserted: ' + cases.size());

// CustomerSentiment__c 별도 update (restricted picklist 캐시 우회)
List<Case> toUpdate = new List<Case>();
for (Integer i = 0; i < cases.size(); i++) {
    Case c = cases[i];
    if (c.Status == 'Escalated' || c.Status == 'Closed') {
        Integer r = Math.mod(i, sentiments.size());
        toUpdate.add(new Case(Id = c.Id, CustomerSentiment__c = sentiments[r]));
    }
}
update toUpdate;
System.debug('Sentiment updated: ' + toUpdate.size());

// 결과 확인
Map<String, Integer> statusCount = new Map<String, Integer>();
for (Case c : cases) {
    String key = c.Status + '|' + c.Origin;
    statusCount.put(key, (statusCount.containsKey(key) ? statusCount.get(key) : 0) + 1);
}
for (String k : statusCount.keySet()) {
    System.debug(k + ' → ' + statusCount.get(k) + '건');
}
