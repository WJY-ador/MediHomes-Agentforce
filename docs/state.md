# State

> 현재 프로젝트 진행 상태 및 주요 결정사항 기록
> 업데이트 시 날짜 명시 필수

---

## 현재 상태 (2026-04-22)

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
- [x] 원정연 데모 데이터 생성
  - Account: `001Ig00000EVfxUIAT` (기존)
  - Contract__c 3개: 2024(만료) / 2025(만료) / 2026(활성)
  - Asset 2개: ResMed AirSense 11 (`02iIg000000tVY3IAM`) / Philips DreamStation 2 (`02iIg000000tVY8IAM`)
  - 병원 연결: `Hospital__c = 001Ig00000EVgeMIAT` (메디홈즈병원)
- [x] InspectionHistory__c 커스텀 필드 6개 배포 (Deploy ID: `0AfIg000003C94oKAC`)
  - Account__c, Asset__c, InspectionDate__c, InspectionType__c, InspectionResult__c, Inspector__c
  - ⚠️ 데이터 삽입 미완료 → 아래 이슈 로그 참고

### 진행 중
- [ ] InspectionHistory__c 데이터 삽입 (이슈 로그 참고)
- [ ] YouTube 카드 Action (`YoutubeCardAction`) — Enhanced Chat v1 마크다운 방식
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
