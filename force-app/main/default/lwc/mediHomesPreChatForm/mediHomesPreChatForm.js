import { api, LightningElement, track } from 'lwc';
import { dispatchMessagingEvent, MESSAGING_EVENT } from 'lightningsnapin/eventStore';

export default class mediHomesPreChatForm extends LightningElement {
    @api configuration;

    @track name = '';
    @track inquiryType = '';

    get isSubmitDisabled() {
        return !this.name.trim();
    }

    handleNameInput(event) {
        this.name = event.target.value;
    }

    handleInquiryChange(event) {
        this.inquiryType = event.target.value;
    }

    handleSubmit() {
        if (!this.name.trim()) return;

        const prechatFields = [
            { name: 'FirstName', value: this.name },
            { name: 'Subject', value: this.inquiryType || '일반 문의' }
        ];

        try {
            if (this.configuration && this.configuration.util && this.configuration.util.startChat) {
                this.configuration.util.startChat(prechatFields);
            } else {
                dispatchMessagingEvent(MESSAGING_EVENT.PRE_CHAT_SUBMIT, { fields: prechatFields });
            }
        } catch (e) {
            dispatchMessagingEvent(MESSAGING_EVENT.PRE_CHAT_SUBMIT, { fields: prechatFields });
        }
    }
}