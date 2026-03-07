import { knownError } from "src/lib/error-models";
import { AttemptToFetch, failure } from "src/lib/functors";
import { ArchetypeName } from "src/repositories/archetype-repo/archetype.models";
import { DeckID } from "src/repositories/deck-repo/deck.models";

export class DeckManager {
    constructor() {}

    getArchetypes = async (deckId: DeckID): AttemptToFetch<{ archetypes: ArchetypeName[] }> => {
        return failure(knownError('Not implemented yet'))
    }
} 