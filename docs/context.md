# MediHomes — Context

> 정적 정보 (비전·요구사항·제약). 자주 바뀌지 않음.
> 진행 상태·태스크는 state.md 참조.

---

## 한 줄 비전
[작성 필요]

## 가상 고객사
**메디 홈즈 (MediHomes)** — [업종/비즈니스 모델 작성 필요]

## Demo Stack
| 제품 | 역할 |
|------|------|
| Agentforce | [역할 작성] |
| Service Cloud | [역할 작성] |

## 핵심 강조 포인트 (필수 — 모든 시나리오에서)
1. **Agentforce 역할**: 단순 챗봇이 아닌 Action을 취하는 AI Agent
2. **Omni-channel routing**: 모든 채널 → Case 자동 생성 + 상담원 자동 배정

## 시나리오 구성
[작성 필요]

## 주요 Salesforce Object

> 2026-04-22 Org 실제 확인 기준 (sf sobject describe)

### Account (Personal Account)
- RecordType: 고객
- 인증 필드: `Birthdate__pc` (생년월일), `PersonMobilePhone` (SMS OTP)
- 환자 정보: `PatientStatus__pc` (환자상태), `InsuranceType__pc` (보험유형), `BillingType__pc` (청구유형), `Gender__pc` (성별)

### Opportunity (= 처방전)
> `Contract__c.Opportunity__c` 레이블이 "처방전" → Opportunity가 처방전 역할

| 필드 | 레이블 | 용도 |
|------|--------|------|
| `EndDate__c` | 처방만료일 | S2 처방전 만료일 조회 |
| `ManualExpireDate__c` | 보정 처방 만료일 | 수동 보정값 |
| `StartDate__c` | 처방시작일 | - |
| `PrescriptionPeriod__c` | 처방기간 | - |
| `PrescriptionStatus__c` | 처방상태 | - |
| `AverageUsageTime__c` | 하루평균사용시간 | S2 순응 기간 조회 |
| `UsageDays__c` | 사용일수 | S2 순응 기간 조회 |
| `CompilanceStartdate__c` | 순응평가 시작일 | S2 순응 기간 조회 |
| `CompilanceEnddate__c` | 순응평가 종료일 | S2 순응 기간 조회 |
| `MaskCheck__c` | 마스크 소모품확인 | S2 보험마스크 구매 |
| `TypeOfPrescription__c` | 처방종류 | - |
| `TypeOfPrescription__c` | 처방종류 | - |
| `InspectionHistory__c` | 점검내역 | → InspectionHistory__c 참조 |

### Contract__c (= 계약)

| 필드 | 레이블 | 용도 |
|------|--------|------|
| `ContractType__c` | 계약유형 | - |
| `ContractStartDate__c` | 계약시작일 | - |
| `ContractEndDate__c` | 계약종료일 | - |
| `ContractStatus__c` | 계약상태 | - |
| `InsuranceClaim__c` | 보험청구여부 | S2 보험마스크 관련 |
| `InsuranceClaimType__c` | 보험청구유형 | - |
| `MonthlyFee__c` | 월 렌탈료 | - |
| `PaymentMethod__c` | 결제방법 | - |
| `Account__c` | 환자 | → Account |
| `Hospital__c` | 병원 | → Account (병원) |
| `Opportunity__c` | 처방전 | → Opportunity |

### Asset (= 기기 / 마스크)

| 필드 | 레이블 | 용도 |
|------|--------|------|
| `Model__c` | 모델명 | S2 사용 기기 조회 |
| `MaskModel__c` | 마스크 모델 | S2 마스크 확인 |
| `MachineType__c` | 양압기 종류 | - |
| `MaskType__c` | 마스크 타입 | - |
| `SerialNumber` | Serial Number | - |
| `PrescribedPressure__c` | 처방 압력 설정값 | - |
| `NextInspectionDate__c` | 다음 점검 예정일 | - |
| `LastInspectionDate__c` | 최근 점검일 | - |
| `FilterReplaceDate__c` | 필터 교체일 | S1 소모품 교체 주기 |
| `MaskReplaceDate__c` | 마스크 교체일 | S1 소모품 교체 주기 |
| `InstallDate__c` | 설치일 | - |
| `WarrantyExpireDate__c` | 보증기간만료일 | - |
| `Contract__c` | 계약 | → Contract__c |
| `Hospital__c` | 병원 | → Account (병원) |

### InspectionHistory__c (= 점검내역)
- 커스텀 필드 없음 (기본 필드만 존재 — 현재 미활용 추정)
- Opportunity에서 참조: `Opportunity.InspectionHistory__c`

### Session_Time__c (= 세션 사용시간)
| 필드 | 레이블 | 용도 |
|------|--------|------|
| `Duration__c` | Duration | 세션 사용시간 |
| `Date__c` | Date | 날짜 |
| `Case__c` | Case | → Case |
| `Agent__c` | Agent | → 상담사 |
| `Manual_Entry__c` | Manual Entry | 수동 입력 여부 |

## 제약 조건
- Demo 완성도: 핵심 Use Case 중심, 빠른 제작
- SDO 환경 기반

---

## 타임라인
```
[작성 필요]
```
