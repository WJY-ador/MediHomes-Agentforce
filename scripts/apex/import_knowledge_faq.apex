// Knowledge FAQ 16개 신규 아티클 임포트
// 필드 패턴: Title=질문, Summary=짧은답변, faq_question__c=질문, faq_answer__c=전체답변, chat_answer__c=짧은답변
// RecordType: SDO_Knowledge_FAQ (012Ig000000PHsjIAG)

List<Knowledge__kav> articles = new List<Knowledge__kav>();

articles.add(new Knowledge__kav(
    Title = '기기 사용 전압은 어떻게 되나요?',
    UrlName = 'device-voltage-info',
    Language = 'ko',
    RecordTypeId = '012Ig000000PHsjIAG',
    faq_question__c = '기기 사용 전압은 어떻게 되나요?',
    Summary = 'AC소비 전력은 100~240 VAC, 50/60HZ, DC 소비 전력은 12VDC, 6.67A입니다.',
    faq_answer__c = '기기 사용 AC소비 전력은 100~240 VAC, 50/60HZ, 2.0~1.0A, DC 소비 전력은 12VDC, 6.67A입니다.',
    chat_answer__c = 'AC소비 전력은 100~240 VAC, 50/60HZ, DC 소비 전력은 12VDC, 6.67A입니다.',
    IsVisibleInPkb = true, IsVisibleInCsp = true
));

articles.add(new Knowledge__kav(
    Title = '세척법 문의',
    UrlName = 'cleaning-method-guide',
    Language = 'ko',
    RecordTypeId = '012Ig000000PHsjIAG',
    faq_question__c = '소모품 세척 방법을 알려주세요.',
    Summary = '마스크 쿠션·물통은 매일 물 세척, 매주 중성세제 세척합니다.',
    faq_answer__c = '마스크 쿠션, 물통 - 매일 물 세척, 매주 중성세제 세척\n마스크 프레임, 호스 - 매주 중성세제 세척\n필터:\n- 피셔/레즈메드: 3개월 주기 무상교체 (세척 불가)\n- 드림스테이션 일반필터(진한파랑색): 2주에 1회 중성세제로 세척, 완전 건조 후 사용 (6개월 주기 무상교체)\n- 드림스테이션 미세필터(하늘색): 세척 불가 (1개월 주기 무상교체)',
    chat_answer__c = '마스크 쿠션·물통은 매일 물 세척, 매주 중성세제 세척합니다.',
    IsVisibleInPkb = true, IsVisibleInCsp = true
));

articles.add(new Knowledge__kav(
    Title = '소모품 구매 가능한 사이트 알려주세요!',
    UrlName = 'consumable-purchase-site',
    Language = 'ko',
    RecordTypeId = '012Ig000000PHsjIAG',
    faq_question__c = '소모품 구매 가능한 사이트 알려주세요!',
    Summary = '현재 자사몰이 없어 고객센터를 통해 구매 가능합니다.',
    faq_answer__c = '현재 이용가능한 자사몰이 없어 구매 원하시는 소모품 말씀해주시면 고객센터에서 구매 도와드리겠습니다. 배송은 2-3일 후 택배로 받아보실 수 있습니다.',
    chat_answer__c = '현재 자사몰이 없어 고객센터를 통해 구매 가능합니다.',
    IsVisibleInPkb = true, IsVisibleInCsp = true
));

articles.add(new Knowledge__kav(
    Title = '폐기해야하는 소모품은 어떻게 폐기하면 되나요?',
    UrlName = 'consumable-disposal-method',
    Language = 'ko',
    RecordTypeId = '012Ig000000PHsjIAG',
    faq_question__c = '폐기해야하는 소모품은 어떻게 폐기하면 되나요?',
    Summary = '폐기 상품은 개별적으로 버리셔도 됩니다.',
    faq_answer__c = '폐기 상품은 개별적으로 버리셔도 됩니다.',
    chat_answer__c = '폐기 상품은 개별적으로 버리셔도 됩니다.',
    IsVisibleInPkb = true, IsVisibleInCsp = true
));

articles.add(new Knowledge__kav(
    Title = '마스크 새로 구매했는데 호스랑 연결되지 않아요.',
    UrlName = 'mask-hose-connection-issue',
    Language = 'ko',
    RecordTypeId = '012Ig000000PHsjIAG',
    faq_question__c = '마스크 새로 구매했는데 호스랑 연결되지 않아요.',
    Summary = '호스 연결부위에 기존 마스크 부품이 꽂혀있는지 확인 후 제거해 주세요.',
    faq_answer__c = '기존 사용하시던 마스크의 일부 부품이 호스에 꽂혀있어 새로 구입한 마스크와 연결되지 않는 경우가 많습니다. 마스크와 호스 연결부위에 마스크 부품의 일부가 꽂혀 있는지 확인하시어 해당 부품을 제거 후 연결 부탁드립니다.',
    chat_answer__c = '호스 연결부위에 기존 마스크 부품이 꽂혀있는지 확인 후 제거해 주세요.',
    IsVisibleInPkb = true, IsVisibleInCsp = true
));

articles.add(new Knowledge__kav(
    Title = '소모품을 분실할 경우 어떻게 해야하나요?',
    UrlName = 'consumable-lost-handling',
    Language = 'ko',
    RecordTypeId = '012Ig000000PHsjIAG',
    faq_question__c = '소모품을 분실할 경우 어떻게 해야하나요?',
    Summary = '소모품 분실 시 본인부담금 비용이 발생할 수 있습니다.',
    faq_answer__c = '임대한 양압기 소모품 분실 시 임대확인서에 안내드린 본인부담금 비용이 발생될 수 있습니다. 분실한 소모품 구매진행 또는 본인부담금 비용 납부로 처리될 예정입니다.',
    chat_answer__c = '소모품 분실 시 본인부담금 비용이 발생할 수 있습니다.',
    IsVisibleInPkb = true, IsVisibleInCsp = true
));

articles.add(new Knowledge__kav(
    Title = '양압기 소모품 건조 빠르게 하는 방법을 알려주세요',
    UrlName = 'cpap-consumable-drying-method',
    Language = 'ko',
    RecordTypeId = '012Ig000000PHsjIAG',
    faq_question__c = '양압기 소모품 건조 빠르게 하는 방법을 알려주세요',
    Summary = '기기에 마스크, 호스 연결 후 작동하여 바람으로 건조하시면 됩니다.',
    faq_answer__c = '기기에 마스크, 호스 연결 후 작동하시어 나오는 바람으로 건조하시면 사용 가능합니다.',
    chat_answer__c = '기기에 마스크, 호스 연결 후 작동하여 바람으로 건조하시면 됩니다.',
    IsVisibleInPkb = true, IsVisibleInCsp = true
));

articles.add(new Knowledge__kav(
    Title = '드림스테이션 WiFi 연결하는 방법',
    UrlName = 'dreamstation-wifi-setup',
    Language = 'ko',
    RecordTypeId = '012Ig000000PHsjIAG',
    faq_question__c = '드림스테이션 WiFi 연결하는 방법을 알려주세요.',
    Summary = '[메뉴]-[내 설정]-[모뎀] 켜짐 활성 후 WiFi를 선택하여 비밀번호를 입력하세요.',
    faq_answer__c = '양압기 본체 좌측에 WiFi 모뎀 장착 여부 확인 후, [메뉴] - [내 설정] - [모뎀] 켜짐 활성 후 사용할 WiFi 아이디 선택하여 비밀번호 입력하시면 됩니다.',
    chat_answer__c = '[메뉴]-[내 설정]-[모뎀] 켜짐 활성 후 WiFi를 선택하여 비밀번호를 입력하세요.',
    IsVisibleInPkb = true, IsVisibleInCsp = true
));

articles.add(new Knowledge__kav(
    Title = '드림스테이션 기기 와이파이 설정 기능이 없어요',
    UrlName = 'dreamstation-no-wifi-setting',
    Language = 'ko',
    RecordTypeId = '012Ig000000PHsjIAG',
    faq_question__c = '드림스테이션 기기 사용중인데, 와이파이 설정 기능이 없어요',
    Summary = '기기 좌측을 열어 WiFi 모뎀 장착 여부를 먼저 확인해 주세요.',
    faq_answer__c = '기기 좌측 부분을 열어보셨을 때, WiFi 모뎀이 들어가있는지 확인 후 모뎀이 없을 경우 출고 여부 확인하여 발송해드립니다. 있을 경우 와이파이 기능 설정 방법 유선으로 확인 진행해드리겠습니다.',
    chat_answer__c = '기기 좌측을 열어 WiFi 모뎀 장착 여부를 먼저 확인해 주세요.',
    IsVisibleInPkb = true, IsVisibleInCsp = true
));

articles.add(new Knowledge__kav(
    Title = '양압기에서 마스크 누출 표시가 나오는건 왜그러는건가요?',
    UrlName = 'cpap-mask-leak-indicator',
    Language = 'ko',
    RecordTypeId = '012Ig000000PHsjIAG',
    faq_question__c = '양압기에서 마스크 누출 표시가 나오는건 왜그러는건가요?',
    Summary = '마스크 착용이 느슨하거나 구강호흡 시 누출 표시가 나타납니다.',
    faq_answer__c = '마스크 착용을 느슨하게 하였거나, 구강호흡으로 인한 누출이 발생되었을 경우 표시됩니다. 마스크 착용을 견고하게 해주시고, 입벌림 방지 테이프를 통하여 구강호흡을 방지해 주시기 바랍니다.',
    chat_answer__c = '마스크 착용이 느슨하거나 구강호흡 시 누출 표시가 나타납니다.',
    IsVisibleInPkb = true, IsVisibleInCsp = true
));

articles.add(new Knowledge__kav(
    Title = '제공받은 임대기기는 몇 년 사용 해야 교체 가능한가요?',
    UrlName = 'rental-device-replacement-timing',
    Language = 'ko',
    RecordTypeId = '012Ig000000PHsjIAG',
    faq_question__c = '제공받은 임대기기는 몇 년 사용 해야 교체 가능한가요?',
    Summary = '기기 교체 시점에 대한 기준은 따로 없으며, 이상 발생 시 고객센터로 연락 주세요.',
    faq_answer__c = '기기 교체 시점에 대한 기준은 따로 없습니다. 사용하시며 기기 이상이 확인되는 경우 고객센터로 연락 부탁드립니다.',
    chat_answer__c = '기기 교체 시점에 대한 기준은 따로 없으며, 이상 발생 시 고객센터로 연락 주세요.',
    IsVisibleInPkb = true, IsVisibleInCsp = true
));

articles.add(new Knowledge__kav(
    Title = '저에게 맞게끔 마스크 사이즈는 어떻게 측정하여 구매하면 되나요?',
    UrlName = 'mask-size-measurement-guide',
    Language = 'ko',
    RecordTypeId = '012Ig000000PHsjIAG',
    faq_question__c = '저에게 맞게끔 마스크 사이즈는 어떻게 측정하여 구매하면 되나요?',
    Summary = '선택하신 마스크에 따른 사이즈를 안내드립니다. 고객센터로 연락 주시면 도와드립니다.',
    faq_answer__c = '선택하신 마스크에 따른 마스크 사이즈를 공유드립니다. 정확한 사이즈 확인을 위해 고객센터로 연락 주시면 안내도와드리겠습니다.',
    chat_answer__c = '선택하신 마스크에 따른 사이즈를 안내드립니다. 고객센터로 연락 주시면 도와드립니다.',
    IsVisibleInPkb = true, IsVisibleInCsp = true
));

articles.add(new Knowledge__kav(
    Title = '호환되는 마스크와 기기를 알려주세요.',
    UrlName = 'compatible-mask-device-guide',
    Language = 'ko',
    RecordTypeId = '012Ig000000PHsjIAG',
    faq_question__c = '호환되는 마스크와 기기를 알려주세요.',
    Summary = '선택하신 기기에 따른 호환 마스크를 안내드립니다. 고객센터로 연락 주시면 도와드립니다.',
    faq_answer__c = '선택하신 기기에 따른 호환 가능한 마스크를 알려드립니다. 정확한 호환 여부 확인을 위해 고객센터로 연락 주시면 안내도와드리겠습니다.',
    chat_answer__c = '선택하신 기기에 따른 호환 마스크를 안내드립니다. 고객센터로 연락 주시면 도와드립니다.',
    IsVisibleInPkb = true, IsVisibleInCsp = true
));

articles.add(new Knowledge__kav(
    Title = 'AirMini 양압기는 어떤 마스크와 호환되나요?',
    UrlName = 'airmini-compatible-masks',
    Language = 'ko',
    RecordTypeId = '012Ig000000PHsjIAG',
    faq_question__c = 'AirMini 양압기는 어떤 마스크와 호환되나요?',
    Summary = 'AirMini와 호환되는 마스크는 N20, P10, F20 세 가지이며 전용 셋업팩이 필요합니다.',
    faq_answer__c = 'AirMini 양압기와 호환되는 마스크는 N20, P10, F20 세 가지입니다. AirMini 양압기 전용 셋업팩(마스크팩)을 구매하셔야 사용 가능한 점 참고 부탁드립니다.',
    chat_answer__c = 'AirMini와 호환되는 마스크는 N20, P10, F20 세 가지이며 전용 셋업팩이 필요합니다.',
    IsVisibleInPkb = true, IsVisibleInCsp = true
));

articles.add(new Knowledge__kav(
    Title = '양압기 사용시간 확인은 어디서 할 수 있나요?',
    UrlName = 'cpap-usage-time-check',
    Language = 'ko',
    RecordTypeId = '012Ig000000PHsjIAG',
    faq_question__c = '양압기 사용시간 확인은 어디서 할 수 있나요?',
    Summary = '양압기 사용시간은 앱 및 기기 화면에서 확인 가능합니다.',
    faq_answer__c = '양압기 사용시간은 이용 중인 양압기 앱 및 기기 화면 내에서 확인 가능합니다.',
    chat_answer__c = '양압기 사용시간은 앱 및 기기 화면에서 확인 가능합니다.',
    IsVisibleInPkb = true, IsVisibleInCsp = true
));

articles.add(new Knowledge__kav(
    Title = '양압기 사용 시 주의사항은 어떻게 되나요?',
    UrlName = 'cpap-usage-precautions',
    Language = 'ko',
    RecordTypeId = '012Ig000000PHsjIAG',
    faq_question__c = '양압기 사용 시 주의사항은 어떻게 되나요?',
    Summary = '평평한 곳에 수평으로 사용하고, 세척 시 뜨거운 물 금지, 이동 시 물통을 비워주세요.',
    faq_answer__c = '기기는 평평한 곳에 수평을 맞춰 사용해주시고, 소모품 세척 시 뜨거운 물 사용 금지, 건조 시 햇빛을 피하여 건조해주시길 바랍니다. 기기 이동 시 물통의 물을 비우고 이동 부탁드립니다. 물통의 물은 기준선(MAX선) 이하로만 채워서 사용 부탁드립니다.',
    chat_answer__c = '평평한 곳에 수평으로 사용하고, 세척 시 뜨거운 물 금지, 이동 시 물통을 비워주세요.',
    IsVisibleInPkb = true, IsVisibleInCsp = true
));

insert articles;
System.debug('생성 완료: ' + articles.size() + '개');
for (Knowledge__kav a : articles) {
    System.debug('ID: ' + a.Id + ' | ' + a.Title);
}
