import { knownError } from "src/lib/error-models";
import { AttemptToFetch, failure } from "src/lib/functors";
import { DeckID } from "src/repositories/deck-repo/deck.models";
import { DeckRepository } from "src/repositories/deck-repo/deck.repo";
import { DeckList } from "./deck.types";
import { UserId } from "src/repositories/user-repo/user.models";

export class DeckManager {
    constructor(private readonly deckRepository: DeckRepository) {}

    loadDeck = async (userId: UserId, deckList: DeckList): AttemptToFetch<DeckID> =>{
        //verify all cards are valid (existing on db and legal) using the card library
        //Store deck using repository 
        //return ID
        return failure(knownError("Not implemented"))
    }
} 