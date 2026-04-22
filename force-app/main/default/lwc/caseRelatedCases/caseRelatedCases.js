import { LightningElement, api, wire } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import getRelatedCases from '@salesforce/apex/MediHomesRelatedCasesController.getRelatedCases';

const CHANNELS = [
    { type: 'icon', label: '웹챗', icon: 'standard:messaging_conversation' },
    { type: 'icon', label: '전화', icon: 'standard:call' },
    { type: 'icon', label: '기타', icon: 'standard:portal' },
];

const STATUS_CLASS = {
    '신규':   'status-new',
    '이관':   'status-escalated',
    '대기중': 'status-waiting',
    'Closed': 'status-closed',
};

export default class CaseRelatedCases extends NavigationMixin(LightningElement) {
    @api recordId;
    cases = [];

    get hasCases() {
        return this.cases.length > 0;
    }

    @wire(getRelatedCases, { caseId: '$recordId' })
    wiredCases({ data, error }) {
        if (data) {
            this.cases = data.map((c, i) => {
                const ch = CHANNELS[i % CHANNELS.length];
                return {
                    ...c,
                    statusClass:   STATUS_CLASS[c.status] || 'status-default',
                    channelIcon:   ch.icon,
                    channelLabel:  ch.label,
                };
            });
        } else if (error) {
            console.error('[caseRelatedCases]', error);
        }
    }

    handleCaseClick(event) {
        const caseId = event.currentTarget.dataset.caseId;
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId:      caseId,
                objectApiName: 'Case',
                actionName:    'view'
            }
        });
    }
}
