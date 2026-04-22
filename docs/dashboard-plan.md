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
| R2 | 질문 유형별 처리 현황 | 막대 | Case | `InquiryType__c`, `Status` | 처리 |
| R3 | 제품별 문의량 | 막대 | Case | `ProductCategory__c` | 분석 |
| R4 | 제품별 이관율 | 막대 | Case + Asset | `ProductCategory__c`, `Status` | 분석 |
| R5 | 장비 모델별 케이스 발생 빈도 | 막대 | Case + Asset | `Asset.Model__c` | 분석 |
| R6 | 보험 유형별 문의 패턴 | 막대 | Case + Account | `Account.InsuranceType__pc` | 환자 |
| R7 | 가장 많이 활용된 FAQ Top 10 | 막대 | CaseArticle + Knowledge | `KnowledgeArticle.Title` | Knowledge |
| R8 | CSAT 분포 + 제품별 평균 | 막대 | Case | `CSAT__c`, `ProductCategory__c` | 결과 |
| R9 | 고객 태도 분포 | 도넛 | Case | `CustomerSentiment__c` | 결과 |

> R7: Knowledge Published 확인됨 → CaseArticle 더미 데이터 채우기 필요

---

## 커스텀 필드 현황 (Case)

| 필드 | 타입 | 피클리스트 값 | 상태 |
|------|------|-------------|------|
| `ProductCategory__c` | Picklist | ResMed AirSense 11 / Philips DreamStation 2 / 마스크 / 소모품·필터 / 기타 | ✅ 배포 완료 |
| `InquiryType__c` | Picklist | 사용방법 / 오류·고장 / 교체·구매 / 계약·렌탈 / 보험·청구 / 점검 요청 / 기타 | ✅ 배포 완료 |
| `CustomerSentiment__c` | Picklist | 매우 만족 / 만족 / 보통 / 불만족 / 매우 불만족 | ✅ 배포 완료 |
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
| Closed | Chat | 280 | 70% | Agentforce 자동처리 |
| Escalated | Chat | 40 | 10% | 상담사 이관 |
| New | Chat | 20 | 5% | 진행 중 |
| Working | Chat | 20 | 5% | 처리 중 |
| Closed/New | Phone | 20 | 5% | 전화 채널 |
| Closed/New | Email | 20 | 5% | 이메일 채널 |
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
- 매우 만족: 15%
- 만족: 30%
- 보통: 25%
- 불만족: 20%
- 매우 불만족: 10%

**CSAT__c** (Closed 케이스)
- 5점: 30%
- 4점: 35%
- 3점: 20%
- 2점: 10%
- 1점: 5%

### AccountId / AssetId
- 원정연 Account(`001Ig00000EVfxUIAT`) 일부 연결
- Asset 2개 분산 배정

---

## 작업 순서

```
[완료] 커스텀 필드 3개 배포 + FLS 부여
[ ] 더미 데이터 400건 생성 (필드값 포함)
[ ] CaseArticle 더미 데이터 생성 (Knowledge 연결)
[ ] 보고서 9개 생성 (Metadata 배포 or Setup UI)
[ ] 대시보드 1장 구성
```

---

## 보고서 생성 방식

- Metadata API 배포 시도
- 실패 시 Setup → Reports → New Report에서 직접 생성

**보고서 폴더명**: `MediHomes_Reports` (생성 필요)
