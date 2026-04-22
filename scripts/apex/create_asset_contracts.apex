// Asset 10개 업데이트 + Contract__c 10개 생성
// 병원: 001Ig00000EVgeMIAT
// 환자: 원정연(001Ig00000EVfxUIAT), 박태원(001Ig00000EVa1tIAD), 김민준(001Ig00000EVa1yIAD)

Id hospitalId    = '001Ig00000EVgeMIAT';
Id wonjeongyeon = '001Ig00000EVfxUIAT';
Id taewon       = '001Ig00000EVa1tIAD';
Id minjun       = '001Ig00000EVa1yIAD';

// Asset ID → 환자 / 가격 / 월납입액 매핑
// 장비(APAP): 3,000,000원 / 마스크: 150,000원 / 소모품: 50,000원
// 월납입: 장비 15,000원 / 마스크·소모품 5,000원
List<Map<String, Object>> assetData = new List<Map<String, Object>>{
    new Map<String, Object>{ 'id' => '02iIg000000tVktIAE', 'patient' => wonjeongyeon, 'price' => 3000000, 'monthly' => 15000, 'type' => 'device' },
    new Map<String, Object>{ 'id' => '02iIg000000tVkuIAE', 'patient' => taewon,       'price' => 3000000, 'monthly' => 15000, 'type' => 'device' },
    new Map<String, Object>{ 'id' => '02iIg000000tVkvIAE', 'patient' => minjun,       'price' => 3000000, 'monthly' => 15000, 'type' => 'device' },
    new Map<String, Object>{ 'id' => '02iIg000000tVkwIAE', 'patient' => wonjeongyeon, 'price' => 3000000, 'monthly' => 15000, 'type' => 'device' },
    new Map<String, Object>{ 'id' => '02iIg000000tVkxIAE', 'patient' => taewon,       'price' => 150000,  'monthly' => 5000,  'type' => 'mask'   },
    new Map<String, Object>{ 'id' => '02iIg000000tVkyIAE', 'patient' => minjun,       'price' => 150000,  'monthly' => 5000,  'type' => 'mask'   },
    new Map<String, Object>{ 'id' => '02iIg000000tVkzIAE', 'patient' => wonjeongyeon, 'price' => 150000,  'monthly' => 5000,  'type' => 'mask'   },
    new Map<String, Object>{ 'id' => '02iIg000000tVl0IAE', 'patient' => taewon,       'price' => 150000,  'monthly' => 5000,  'type' => 'mask'   },
    new Map<String, Object>{ 'id' => '02iIg000000tVl1IAE', 'patient' => wonjeongyeon, 'price' => 50000,   'monthly' => 5000,  'type' => 'supply' },
    new Map<String, Object>{ 'id' => '02iIg000000tVl2IAE', 'patient' => taewon,       'price' => 50000,   'monthly' => 5000,  'type' => 'supply' }
};

// 2025-01-01 ~ 2026-04-22: 477일
Date baseDate = Date.newInstance(2025, 1, 1);
Date today    = Date.newInstance(2026, 4, 22);
Integer totalDays = 477;

// ----- Contract__c 생성 먼저 (Asset.Contract__c 연결용) -----
List<Contract__c> contracts = new List<Contract__c>();
List<Integer> paymentDays = new List<Integer>{ 5, 10, 15, 20, 25, 5, 10, 15, 20, 25 };

for (Integer i = 0; i < assetData.size(); i++) {
    Map<String, Object> d = assetData[i];
    Integer rnd = Math.mod(Math.abs(Crypto.getRandomInteger()), totalDays);
    Date startDate = baseDate.addDays(rnd);
    Date endDate   = startDate.addYears(1);
    String status  = (startDate <= today && endDate >= today) ? '활성' : '만료';
    Integer monthlyFee = (Integer) d.get('monthly');
    Integer totalAmt   = monthlyFee * 12;

    Contract__c c = new Contract__c(
        Account__c             = (Id) d.get('patient'),
        Hospital__c            = hospitalId,
        ContractType__c        = '렌탈',
        ContractStartDate__c   = startDate,
        ContractEndDate__c     = endDate,
        ContractStatus__c      = status,
        MonthlyFee__c          = monthlyFee,
        TotalAmount__c         = totalAmt,
        PaymentMethod__c       = '자동이체',
        PaymentDay__c          = paymentDays[i],
        InsuranceClaim__c      = true,
        InsuranceClaimType__c  = '건강보험'
    );
    contracts.add(c);
}
insert contracts;
System.debug('Contracts inserted: ' + contracts.size());

// ----- Asset 업데이트 (AccountId, Hospital__c, 날짜, 가격, Contract__c 연결) -----
List<Id> assetIds = new List<Id>();
for (Map<String, Object> d : assetData) assetIds.add((Id) d.get('id'));

Map<Id, Asset> assetMap = new Map<Id, Asset>(
    [SELECT Id, MachineType__c FROM Asset WHERE Id IN :assetIds]
);

List<Asset> toUpdate = new List<Asset>();
for (Integer i = 0; i < assetData.size(); i++) {
    Map<String, Object> d = assetData[i];
    Id aId = (Id) d.get('id');
    Asset a = assetMap.get(aId);
    if (a == null) continue;

    Integer rnd2 = Math.mod(Math.abs(Crypto.getRandomInteger()), totalDays);
    Date installDate   = baseDate.addDays(rnd2);
    Date purchaseDate  = installDate.addDays(-(Math.mod(Math.abs(Crypto.getRandomInteger()), 14) + 1));
    Date usageEndDate  = installDate.addYears(1);

    a.AccountId    = hospitalId;
    a.Hospital__c  = hospitalId;
    a.InstallDate  = installDate;
    a.PurchaseDate = purchaseDate;
    a.UsageEndDate = usageEndDate;
    a.Price        = (Decimal) d.get('price');
    a.Contract__c  = contracts[i].Id;

    toUpdate.add(a);
}
update toUpdate;
System.debug('Assets updated: ' + toUpdate.size());

// ----- 결과 출력 -----
for (Integer i = 0; i < contracts.size(); i++) {
    Map<String, Object> d = assetData[i];
    System.debug('Asset[' + i + '] ' + d.get('id') + ' → Contract: ' + contracts[i].Id
        + ' (' + contracts[i].ContractStartDate__c + ' ~ ' + contracts[i].ContractEndDate__c
        + ' / ' + contracts[i].ContractStatus__c + ')');
}
