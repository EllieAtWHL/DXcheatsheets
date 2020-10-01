import { NavigationMixin, CurrentPageReference } from 'lightning/navigation';
import { fireEvent } from 'c/pubsub';
import { loadStyle } from 'lightning/platformResourceLoader';
import ghResources from '@salesforce/resourceUrl/ghResources';
import { LightningElement, track, wire } from 'lwc';
/** PlayerController.searchplayers(searchTerm) Apex method */
import searchPlayers from '@salesforce/apex/PlayerController.searchPlayers';
export default class PlayerSearch extends NavigationMixin(LightningElement) {
	@track searchTerm = '';
	@track players;
	@wire(CurrentPageReference) pageRef;
	@wire(searchPlayers, {searchTerm: '$searchTerm'})
	loadplayers(result) {
		this.players = result;
		if (result.data) {
			fireEvent(this.pageRef, 'playerListUpdate', result.data);
		}
	}
	connectedCallback() {
		loadStyle(this, ghResources + '/style.css');
	}
	handleSearchTermChange(event) {
		// Debouncing this method: do not update the reactive property as
		// long as this function is being called within a delay of 300 ms.
		// This is to avoid a very large number of Apex method calls.
		window.clearTimeout(this.delayTimeout);
		const searchTerm = event.target.value;
		// eslint-disable-next-line @lwc/lwc/no-async-operation
		this.delayTimeout = setTimeout(() => {
			this.searchTerm = searchTerm;
		}, 300);
	}
	get hasResults() {
		return (this.players.data.length > 0);
	}
	handlePlayerView(event) {
		/***************************
		 * This bit needs to be changed, bur PoC for now)
		 *
		 */

		// Get player record id from playerview event
		const playerId = event.detail;
		// Navigate to player record page
		this[NavigationMixin.Navigate]({
			type: 'standard__recordPage',
			attributes: {
				recordId: playerId,
				objectApiName: 'Contact',
				actionName: 'view',
			},
		});
	}
}