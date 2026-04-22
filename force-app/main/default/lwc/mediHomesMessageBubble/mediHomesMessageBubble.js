import { api, LightningElement } from "lwc";
const MESSAGE_CONTENT_CLASS = "embedded-messaging-message-content";
const ENDUSER = "EndUser";
const AGENT = "Agent";
const CHATBOT = "Chatbot";
const PARTICIPANT_TYPES = [ENDUSER, AGENT, CHATBOT];

export default class mediHomesMessageBubble extends LightningElement {
    @api configuration;
    @api conversationEntry;

    get sender() {
        return this.conversationEntry && this.conversationEntry.sender && this.conversationEntry.sender.role;
    }

    get isAgent() {
        return this.sender === AGENT || this.sender === CHATBOT;
    }

    get textContent() {
        try {
            const entryPayload = JSON.parse(this.conversationEntry.entryPayload);
            if (entryPayload.abstractMessage && entryPayload.abstractMessage.staticContent) {
                return entryPayload.abstractMessage.staticContent.text || '';
            }
            return "";
        } catch (e) {
            console.error(e);
        }
    }

    get generateMessageBubbleClassname() {
        if (this.isSupportedSender()) {
            return `${MESSAGE_CONTENT_CLASS} ${this.sender}`;
        }
        return MESSAGE_CONTENT_CLASS;
    }

    get bubbleWrapClass() {
        return 'bubble-wrap ' + (this.isAgent ? 'agent' : 'user');
    }

    get formattedTime() {
        try {
            if (!this.conversationEntry || !this.conversationEntry.clientTimestamp) return '';
            const date = new Date(this.conversationEntry.clientTimestamp);
            return date.toLocaleTimeString('ko-KR', { hour: '2-digit', minute: '2-digit', hour12: false });
        } catch (e) {
            return '';
        }
    }

    isSupportedSender() {
        return PARTICIPANT_TYPES.some(type => this.sender === type);
    }
}