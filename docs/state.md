# State

> 현재 프로젝트 진행 상태 및 주요 결정사항 기록
> 업데이트 시 날짜 명시 필수

---

## 현재 상태 (2026-04-23) — 업데이트 2

### 완료
- [x] Salesforce 프로젝트 생성 (MediHomes, API 66.0)
- [x] CLAUDE.md / .claude/CLAUDE.md 세팅
- [x] Git 레포 생성 (WJY-ador/MediHomes-Agentforce) + 브랜치 구조 세팅 (main / develop)
- [x] 데모 시나리오 3개 확정 → `docs/scenario.md` 작성
- [x] FAQ 엑셀 분석 → 시나리오별 예시 질문/답변 매핑 완료
- [x] Experience Cloud 페이지 배경 LWC `medihomesCommunityBackground` 생성 및 Org 배포 완료 (Deploy ID: `0AfIg000003C4qKKAS`)
- [x] Cafe24 이미지 CDN CSP Trusted Site `Cafe24ImageCdn` 추가 및 Org 배포 완료
- [x] Org 세팅 완료 (Data Cloud, Lightning Knowledge 활성화 확인)
- [x] Org 실제 스키마 확인 → `docs/context.md` 업데이트
  - Account 생년월일: `Birthdate__pc` 확인
  - Prescription__c 없음 → **Opportunity가 처방전 역할** 확인
  - Contract__c, Asset, InspectionHistory__c, Session_Time__c 필드 확인
- [x] Apex Action 2개 작성 및 배포
  - `MediHomesLookupEmailByNameDOB` — 이름+생년월일 → 이메일/전화 조회
  - `MediHomesOTPSender` — OTP 생성 + 이메일 발송
- [x] InspectionHistory__c 커스텀 필드 FLS 이슈 해결
  - 원인: System Administrator 프로필 FLS 미설정 + PermissionSet 미assign
  - 해결: 88개 프로필 전체 FieldPermissions 직접 부여 (Apex)
  - PermissionSet `InspectionHistoryAccess` 생성 및 전체 사용자 assign
- [x] 원정연 데모 데이터 생성 완료
  - Account: `001Ig00000EVfxUIAT`
  - Contract__c 3개: C-0004(2024 만료) / C-0005(2025 만료) / C-0006(2026 활성)
  - Asset 2개: ResMed AirSense 11 (`02iIg000000tVY3IAM`) / Philips DreamStation 2 (`02iIg000000tVY8IAM`)
  - InspectionHistory__c 3건: 2026-01-15(정기) / 2025-07-10(방문) / 2025-03-22(정기)
  - Opportunity(처방전) 3건: 2024(`006Ig000004C29PIAS`) / 2025(`006Ig000004C29QIAS`) / 2026(`006Ig000004C29RIAS`)
    - Layout 필드 전체 입력 완료 (Contact__c 제외)
    - PrePrescription__c / NextPrescription__c 체인 연결 완료
    - Contract__c.Opportunity__c 연결 완료
- [x] Service Console용 LWC 2개 작성 및 Org 배포 완료 (Deploy ID: `0AfIg000003C953KAC`)
  - `agentDailyBanner` — Case 레코드 상단 환자 정보 배너 (환자명/환자상태/보험유형/명언)
    - Apex: `MediHomesPatientBannerController`
  - `caseRelatedCases` — 동일 환자 이전 케이스 목록 (채널: 웹챗/전화/기타)
    - Apex: `MediHomesRelatedCasesController`

- [x] 대시보드/보고서 계획 확정 → `docs/dashboard-plan.md`
  - Case 커스텀 필드 3개 (ProductCategory__c / InquiryType__c) 배포 완료
  - CustomerSentiment__c 피클리스트 값 수정 + 배포 완료 (긍정/보통/부정/알수없음, Deploy ID: `0AfIg000003C96VKAS`)
  - FLS 전체 프로필 부여 완료 (201/264건)
  - 보고서 9개 설계 확정, 더미 데이터 400건 계획 수립
- [x] Asset 10개 AccountId 수정 완료 — 환자 계정으로 올바르게 매핑
- [x] CaseArticle 더미 데이터 20건 생성 완료 (R7 FAQ Top 10용)
  - Tier 1 (3케이스): 마스크 보험 / 압력 약해짐 / 순응 기간
  - Tier 2 (2케이스): 기기 점검·수리 / 계약 해지 / 임대료 / 고장 문의
  - Tier 3 (1케이스): 수면다원검사 / 결제 변경 / 주소 변경
- [x] 보고서 6개 메타데이터 배포 완료 (`MediHomes_Reports` 폴더)
  - R1 Agentforce vs 상담사 이관 비율 (Summary, ORIGIN 그룹)
  - R2 질문 유형별 처리 현황 (Summary, InquiryType + Status 그룹)
  - R3 제품별 문의량 (Summary, ProductCategory 그룹)
  - R4 제품별 이관율 (Matrix, ProductCategory × Status)
  - R8 CSAT 점수 분포 (Summary, CSAT 그룹, Closed 필터)
  - R9 고객 태도 분포 (Summary, CustomerSentiment 그룹)
  - R5/R6/R7 → 사람이 Setup UI에서 직접 생성
- [x] Asset 10개 업데이트 완료
  - AccountId = 환자 계정 (원정연 4개 / 박태원 4개 / 김민준 2개)
  - InstallDate / PurchaseDate / UsageEndDate / Price / Contract__c 모두 채움
  - `02iIg000000tVktIAE` 레즈메드 에어센스10 오토셋 (CPAP) → 원정연
  - `02iIg000000tVkuIAE` 필립스 드림스테이션 오토셋 (CPAP) → 박태원
  - `02iIg000000tVkvIAE` 레즈메드 에어미니 오토셋 (CPAP) → 김민준
  - `02iIg000000tVkwIAE` BMC M1 미니 오토셋 (CPAP) → 원정연
  - `02iIg000000tVkxIAE` 레즈메드 에어핏 N30i (마스크) → 박태원
  - `02iIg000000tVkyIAE` 레즈메드 에어핏 N20 (마스크) → 김민준
  - `02iIg000000tVkzIAE` 레즈메드 에어핏 P30i (마스크) → 원정연
  - `02iIg000000tVl0IAE` 레즈메드 에어핏 P10 (마스크) → 박태원
  - `02iIg000000tVl1IAE` 레즈메드 S10 열선 호스 (소모품) → 원정연
  - `02iIg000000tVl2IAE` 레즈메드 에어미니 N20 셋업팩 (소모품) → 박태원
- [x] Contract__c 10개 생성 완료 (scripts/apex/create_asset_contracts.apex)
  - Hospital__c = 병원 / 렌탈 / 자동이체 / 건강보험
  - 환자 분배: 원정연 4개 / 박태원 4개 / 김민준 2개
- [x] 김민준 Account 필드 보완 — InsuranceType__pc=의료급여, PatientStatus__pc=순응중
- [x] 더미 케이스 100건 생성 완료 (scripts/apex/create_dummy_cases.apex)
  - Closed/Ai Chat: 70건 / Escalated/상담사이관: 10건 / New: 10건 / Working: 10건
  - CustomerSentiment__c(80건) / CSAT__c(70건) / ProductCategory__c / InquiryType__c / AssetId 채움
  - CustomerSentiment__c restricted 배포 이슈 → restricted:false 우회 후 restricted:true 복원
- [x] develop 브랜치 커밋 완료 (55 files, d993cad)
- [x] 기존 케이스 OwnerId 일괄 업데이트 — 이관 25건→김상담(005Ig000001jFfFIAU) / AI Chat 249건→EinsteinServiceAgent User(005Ig000001jG9mIAE)
- [x] 보고서 데이터 싱크 수정 완료 (2026-04-23)
  - Case Origin `상담사 이관` (공백) 1건 → `상담사이관` 수정 후 전체 118건 `상담사 이관` 통일
  - R1 보고서 날짜 필터 배포 (2025-01-01 ~ 2026-12-31, Deploy ID: `0AfIg000003C9lGKAS`)
  - R2~R9 보고서 날짜 + Origin 필터 배포 (Deploy ID: `0AfIg000003C9oyKAC`)
  - 대시보드 `01ZIg000000TZEGMA4` 최종 확인 완료
- [x] 더미 케이스 200건 추가 생성 완료 (scripts/apex/create_dummy_cases_v2.apex) — 총 ~401건
  - ResMed AirSense 11: 77건 이관율 7% / Philips DreamStation 2: 53건 이관율 24%
  - 마스크: 37건 이관율 2% / 소모품·필터: 19건 이관율 10% / 기타: 14건 이관율 21%
  - Owner: 이관→김상담 / AI Chat→EinsteinServiceAgent User
  - restricted picklist 우회 패턴 재사용 (CustomerSentiment__c, InquiryType__c)

### 진행 중
- [ ] YouTube 링크 Action — **홀드** (설계 확정)
  - Knowledge__kav 에 `VideoURL__c` (URL) 커스텀 필드 추가
  - Apex Action `MediHomesKnowledgeFAQ`: userQuery → answerText + videoUrl 반환
  - Agent Instructions: videoUrl 있으면 `[영상 보기](url)` 형식 포함
  - YouTube URL은 플레이스홀더로 우선 입력 → 실제 URL 교체 예정
  - ⚠️ Knowledge 아티클 임포트 완료 후 진행
- [ ] S2 데이터 조회 Apex — 처방전 만료일, 순응 기간, Asset 조회
- [ ] 박태원 데모 데이터 생성 (원정연과 동일한 구조)

### 미결 / 보류
- 시나리오 3 상세 구성 → 팀 미팅 후 확정
- Knowledge 문서 범위 결정 (전체 FAQ vs 데모용 일부)

### 블로커
없음

---

## 주요 결정사항

| 날짜 | 결정 | 근거 |
|------|------|------|
| 2026-04-15 | 데모 시나리오 3개 확정 | 고객사 활용방안 문서 기반 |
| 2026-04-15 | 인증 방식: 이름+생년월일 → 동명이인 시 SMS OTP | Salesforce 표준 `Verify Customer Identity` Action 활용 |
| 2026-04-15 | 시나리오 4(수면 콘텐츠) 제외 | 웹챗 데모 범위 밖 (아웃바운드 발송 필요) |
| 2026-04-15 | Git 레포: 기존 MediHomes 폴더에 remote 연결 | 새 폴더 불필요 |
| 2026-04-15 | Partner Community 배경은 원본 Cafe24 스크립트 복제가 아닌 독립 LWC로 재구성 | 외부 라이선스/스크립트 의존성 제거, Experience Builder 호환성 확보 |

---

## 데모 시나리오 요약

| # | 시나리오 | 인증 | 핵심 |
|---|----------|------|------|
| 1 | 초기 순응 케어 + 기기/소모품 FAQ | ❌ | Knowledge 기반 즉시 답변 |
| 2 | 나의 정보 조회 | ✅ 이름+생년월일 (동명이인 시 SMS OTP) | Prescription/Asset/Order 데이터 조회 |
| 3 | 상담사 이관 + Case 생성 | - | 미해결 시 Case 자동 생성 + 상담사 연결 |

---

## 미결 사항 로그

| 날짜 | 항목 | 상태 |
|------|------|------|
| 2026-04-15 | Account 생년월일 필드명 확인 | ✅ `Birthdate__pc` 확인 (2026-04-22) |
| 2026-04-15 | Account MobilePhone 데이터 유무 | 미확인 |
| 2026-04-15 | Sandbox DC/Knowledge 활성화 여부 | ✅ Org 세팅 완료 (2026-04-22) |
| 2026-04-15 | Experience Builder 페이지에 `medihomesCommunityBackground` 추가 후 실제 렌더링 확인 | 미확인 |
| 2026-04-22 | Opportunity → 처방전 역할 확인 (Prescription__c 없음) | ✅ 확인 |
| 2026-04-22 | S2 조회용 Apex 작성 | 진행 중 |
| 2026-04-22 | YouTube 카드 Action 작성 | 진행 중 |
| 2026-04-22 | InspectionHistory__c SOQL 불가 원인 규명 | 미해결 → 이슈 로그 참고 |
| 2026-04-22 | 원정연 Account MobilePhone null | Phone(010-6033-5105) 있음. Apex은 Phone 필드 사용 중 — 문제 없음 |

---

## 에러 / 이슈 로그

| 날짜 | 이슈 | 해결 |
|------|------|------|
| 2026-04-15 | `sf project deploy quick`가 validate Job 재사용 불가 오류 반환 | `sf project deploy start --source-dir force-app/main/default/lwc/medihomesCommunityBackground --target-org vscodeOrg`로 배포 성공 |
| 2026-04-22 | InspectionHistory__c 필드 배포 성공했으나 SOQL/Apex에서 `No such column` 오류 | 미해결. 원인: SDO 특수 오브젝트로 EntityDefinition ID = `000000000000000AAA`. FieldDefinition Tooling API에선 필드 조회 가능, UI 레이아웃에도 표시되나 DML/SOQL 불가. 다음 세션에서 REST API 직접 호출 또는 신규 오브젝트 생성 방향으로 시도 필요. |
