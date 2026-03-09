import { knownError } from "src/lib/error-models";
import { AttemptToFetch, failure } from "src/lib/functors";
import { ArchetypeName } from "src/repositories/archetype-repo/archetype.models";
import { DeckID } from "src/repositories/deck-repo/deck.models";
import { DeckRepository } from "src/repositories/deck-repo/deck.repo";

export class DeckManager {
    constructor(private readonly deckRepository: DeckRepository) {}

    getArchetypes = async (deckId: DeckID): AttemptToFetch<{ archetypes: ArchetypeName[] }> => {
        return failure(knownError('Not implemented yet'))
    }
} 