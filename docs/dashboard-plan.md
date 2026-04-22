# MediHomes 대시보드 / 보고서 계획

> 작성일: 2026-04-22
> 목적: Agentforce 도입 효과 — 상담사 리소스 절감 시각화

---

## 핵심 스토리 (퍼널)

```
전체 문의 유입
    ↓ Agentforce 단순 문의 자동처리
상담사 여유 시간 확보
    ↓ 복잡한 케이스 집중 + 업셀 기회
고객 만족도 상승 → Closed
```

---

## 대시보드 구성 (1장)

보고서 9개 → 대시보드 1장으로 통합

---

## 보고서 9개

| # | 제목 | 차트 | 오브젝트 | 핵심 필드 | 레벨 |
|---|------|------|---------|----------|------|
| R1 | Agentforce vs 상담사 이관 비율 | 도넛 | Case | `Status` (Escalated = 이관) | 처리 |
| R2 | 질문 유형별 처리 현황 | 가로 막대 | Case | `InquiryType__c`, `Status` | 처리 |
| R3 | 제품별 문의량 | 도넛 | Case | `ProductCategory__c` | 분석 |
| R4 | 제품별 이관율 | 누적 세로막대 | Case | `ProductCategory__c`, `Status` | 분석 |
| R5 | 장비 모델별 케이스 발생 빈도 | 세로 막대 | Case + Asset | `Asset.Model__c` | 분석 |
| R6 | 보험 유형별 문의 패턴 | 도넛 | Case + Account | `Account.InsuranceType__pc` | 환자 |
| R7 | 가장 많이 활용된 FAQ Top 10 | 가로 막대 | CaseArticle + Knowledge | `KnowledgeArticle.Title` | Knowledge |
| R8 | CSAT 점수 분포 | 세로 막대 | Case | `CSAT__c` | 결과 |
| R9 | 고객 태도 분포 | 도넛 | Case | `CustomerSentiment__c` | 결과 |

> R7: Knowledge Published 확인됨 → CaseArticle 더미 데이터 채우기 필요

---

## 커스텀 필드 현황 (Case)

| 필드 | 타입 | 피클리스트 값 | 상태 |
|------|------|-------------|------|
| `ProductCategory__c` | Picklist | ResMed AirSense 11 / Philips DreamStation 2 / 마스크 / 소모품·필터 / 기타 | ✅ 배포 완료 |
| `InquiryType__c` | Picklist | 사용방법 / 오류·고장 / 교체·구매 / 계약·렌탈 / 보험·청구 / 점검 요청 / 기타 | ✅ 배포 완료 |
| `CustomerSentiment__c` | Picklist | 긍정 / 보통 / 부정 / 알수없음 | ✅ 배포 완료 |
| `CSAT__c` | Number | 1 ~ 5 (정수) | ✅ 기존 필드 |

**활용 표준 필드**
- Case: `Status`, `Origin`, `AssetId`, `AccountId`, `CreatedDate`
- Asset: `Model__c`, `MachineType__c`
- Account: `InsuranceType__pc`, `PatientStatus__pc`

---

## 더미 데이터 계획 (400건)

### Case 분포

| Status | Origin | 건수 | 비율 | 설명 |
|--------|--------|------|------|------|
| Closed | Ai Chat | 280 | 70% | Agentforce 자동처리 |
| Escalated | 상담사 이관 | 40 | 10% | 상담사 이관 |
| New | Ai Chat | 20 | 5% | 진행 중 |
| Working | Ai Chat | 20 | 5% | 처리 중 |
| Closed | 상담사 이관 | 40 | 10% | 상담사 처리 완료 |
| **합계** | | **400** | **100%** | |

### 필드별 값 분포 (예정)

**ProductCategory__c**
- ResMed AirSense 11: 35%
- Philips DreamStation 2: 30%
- 마스크: 20%
- 소모품·필터: 10%
- 기타: 5%

**InquiryType__c**
- 사용방법: 25%
- 오류·고장: 20%
- 교체·구매: 20%
- 계약·렌탈: 15%
- 보험·청구: 10%
- 점검 요청: 5%
- 기타: 5%

**CustomerSentiment__c** (Escalated 케이스 위주)
- 긍정: 30%
- 보통: 30%
- 부정: 25%
- 알수없음: 15%

**CSAT__c** (Closed 케이스)
- 5점: 30%
- 4점: 35%
- 3점: 20%
- 2점: 10%
- 1점: 5%

### AccountId / AssetId 연결 현황

**환자 Account (Case.AccountId 분배용)**
| 환자 | Account ID | 비율 |
|------|-----------|------|
| 원정연 | `001Ig00000EVfxUIAT` | 40% |
| 박태원 | `001Ig00000EVa1tIAD` | 35% |
| 김민준 | `001Ig00000EVa1yIAD` | 25% |

**병원 Account**: `001Ig00000EVgeMIAT`

**Asset 10개 (Case.AssetId 분배용)**
| Asset ID | 제품명 | 환자 | Contract ID |
|----------|--------|------|------------|
| `02iIg000000tVktIAE` | 레즈메드 에어센스10 오토셋 (CPAP) | 원정연 | `a2sIg000000L0LqIAK` |
| `02iIg000000tVkuIAE` | 필립스 드림스테이션 오토셋 (CPAP) | 박태원 | `a2sIg000000L0LrIAK` |
| `02iIg000000tVkvIAE` | 레즈메드 에어미니 오토셋 (CPAP) | 김민준 | `a2sIg000000L0LsIAK` |
| `02iIg000000tVkwIAE` | BMC M1 미니 오토셋 (CPAP) | 원정연 | `a2sIg000000L0LtIAK` |
| `02iIg000000tVkxIAE` | 레즈메드 에어핏 N30i (마스크) | 박태원 | `a2sIg000000L0LuIAK` |
| `02iIg000000tVkyIAE` | 레즈메드 에어핏 N20 (마스크) | 김민준 | `a2sIg000000L0LvIAK` |
| `02iIg000000tVkzIAE` | 레즈메드 에어핏 P30i (마스크) | 원정연 | `a2sIg000000L0LwIAK` |
| `02iIg000000tVl0IAE` | 레즈메드 에어핏 P10 (마스크) | 박태원 | `a2sIg000000L0LxIAK` |
| `02iIg000000tVl1IAE` | 레즈메드 S10 열선 호스 (소모품) | 원정연 | `a2sIg000000L0LyIAK` |
| `02iIg000000tVl2IAE` | 레즈메드 에어미니 N20 셋업팩 (소모품) | 박태원 | `a2sIg000000L0LzIAK` |

---

## 작업 순서

```
[완료] 커스텀 필드 3개 배포 + FLS 부여
       ProductCategory__c / InquiryType__c ✅ 배포 완료
       CustomerSentiment__c ⚠️ 값 수정 완료 → 배포 대기
[완료] Asset 10개 업데이트
       AccountId = 병원(001Ig00000EVgeMIAT), Hospital__c 연결
       InstallDate / PurchaseDate / UsageEndDate / Price / Contract__c 모두 채움
[완료] Contract__c 10개 생성
       환자 분배: 원정연 4개 / 박태원 4개 / 김민준 2개
       Hospital__c = 병원 / ContractType = 렌탈 / 자동이체 / 건강보험
[완료] ① CustomerSentiment__c 배포 완료 (0AfIg000003C96VKAS)
[완료] ② 더미 케이스 100건 생성 완료 (scripts/apex/create_dummy_cases.apex)
       Closed/Ai Chat:70 / Escalated/상담사이관:10 / New:10 / Working:10
       ※ 추후 400건으로 확장 시 스크립트 재사용
[ ] ③ CaseArticle 더미 데이터 생성 (Knowledge 연결, R7용)
[ ] ④ 보고서 9개 생성 (Setup → Reports)
       폴더명: MediHomes_Reports (생성 필요)
[ ] ⑤ 대시보드 1장 구성
```

---

## 보고서 생성 방식

- Metadata API 배포 시도
- 실패 시 Setup → Reports → New Report에서 직접 생성

**보고서 폴더명**: `MediHomes_Reports` (생성 필요)
