module TicketTutorial::tickets {
	#[test_only]
    use std::signer;

	struct ConcertTicket has key {
		seat: vector<u8>,
		ticket_code: vector<u8>,
	}

	public fun create_ticket(recipient: &signer, seat: vector<u8>, ticket_code: vector<u8>)  {
		move_to<ConcertTicket>(recipient, ConcertTicket {seat, ticket_code})
	}

	#[test(recipient = @0x1)]
	public entry fun sender_can_create_ticket(recipient: signer) {
		create_ticket(&recipient, b"A24", b"AB43C7F");
		let recipient_addr = signer::address_of(&recipient);
		assert!(exists<ConcertTicket>(recipient_addr), 1);
	}
}