import { ColorIdentity } from "src/lib/entities";
import {prisma} from "../../lib/prisma"
import { AttemptToFetch, failure } from "src/lib/functors";
import { ArchetypeInstance } from "./archetype.models";
import { knownError } from "src/lib/error-models";
export class ArchetypeRepository {
    private table = prisma.archetype

    constructor() {}

    getByColorIdentity = async (colorId: ColorIdentity): AttemptToFetch<ArchetypeInstance> => {
        return failure(knownError("not implemented"))
    }
}