import { AttemptToFetch, failure } from "src/lib/functors";
import { CardName, CardRecord } from "./card-library.models";
import { knownError } from "src/lib/error-models";

export class CardLibrary {
    constructor() {}

    search = async (name: CardName): AttemptToFetch<CardRecord> => {
        return failure(knownError("not implemented"));
    }
} 