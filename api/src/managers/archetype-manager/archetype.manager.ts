import { ArchetypeRepository } from "src/repositories/archetype-repo/archetype.repo";
import { DeckID } from "src/repositories/deck-repo/deck.models";
import { QueueFactory } from "src/tools/queue-factory/queue-factory";

export class ArchetypeManager {
    private tagDeckQueue: QueueFactory<DeckID>

    constructor(private archetypeRepo: ArchetypeRepository){
        this.tagDeckQueue = new QueueFactory("archetype tag", this.tagDeckLogic)
    }

    private tagDeckLogic = async (deckId: DeckID) => {
        
    }

    public tagDeck = async (deckId: DeckID) => {
        this.tagDeckQueue.enqueue(deckId)
    }

}