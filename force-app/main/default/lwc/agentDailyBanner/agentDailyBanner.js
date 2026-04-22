import { LightningElement, api, wire } from 'lwc';
import getPatientInfo from '@salesforce/apex/MediHomesPatientBannerController.getPatientInfo';

const QUOTES = [
    '고객의 목소리는\n우리 성장의 나침반입니다.\n오늘도 귀 기울여 주세요.',
    '오늘의 작은 친절이\n내일의 깊은 신뢰를 만듭니다.\n한 마디가 브랜드가 됩니다.',
    '고객 한 분의 감동은\n더 큰 추천으로 이어집니다.\n오늘도 진심을 전해 주세요.',
    '문제 해결을 넘어\n다시 찾고 싶은 경험을\n함께 만들어 주세요.',
    '최고의 서비스는\n기대를 조용히 뛰어넘는\n작은 디테일에서 시작됩니다.',
    '상담 한 건 한 건이\n우리 브랜드의 얼굴입니다.\n자랑스러운 하루 만들어 가요.',
    '대화가 끝난 뒤에도\n좋은 기억이 남을 수 있게\n오늘도 최선을 다해 주세요.'
];

export default class AgentDailyBanner extends LightningElement {
    @api recordId;
    patientName   = '';
    patientStatus = '';
    insuranceType = '';
    quote         = QUOTES[new Date().getDate() % QUOTES.length];

    @wire(getPatientInfo, { caseId: '$recordId' })
    wiredInfo({ data, error }) {
        if (data) {
            this.patientName   = data.patientName   || '';
            this.patientStatus = data.patientStatus || '';
            this.insuranceType = data.insuranceType || '';
        } else if (error) {
            console.error('[agentDailyBanner]', error);
        }
    }
}
