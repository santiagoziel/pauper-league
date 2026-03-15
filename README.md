# Pauper League Metagame Tracker

A web application for tracking the metagame of a Magic: The Gathering Pauper league. It manages player decks, records game results across events, and automatically classifies decks into archetypes based on their card composition.

## Core Concepts

### Cards and Decks

Cards are the fundamental unit. Each unique card in the format has a single record in the database, created on demand when a deck containing it is first loaded. Cards store their name, a reference link, and their color identity.

A deck belongs to a user and is composed of deck list records, each representing a card, its quantity, and whether it belongs to the mainboard or sideboard. Standard Pauper decks run 60 mainboard cards and up to 15 sideboard cards, though minor variation in count is possible.

Decks carry a status (valid, incomplete, illegal, or default) reflecting whether they meet format legality requirements.

### Archetype Detection

The most significant feature of the application is automatic archetype classification. In Magic: The Gathering, decks fall into named archetypes (e.g., "Elves", "Affinity", "Heroic") that describe their strategy and card composition.

#### Archetype Structure

Archetypes are organized in a two-level hierarchy:

- **Category** -- A broad strategic classification such as Aggro, Control, Combo, Midrange, Ramp, or hybrid combinations like Aggro-Combo. Every archetype belongs to a category.
- **Main Archetype** -- A named archetype like "Elves" or "Affinity". Main archetypes have no parent.
- **Sub-Archetype** -- A more specific variant under a main archetype. For example, "Elf Ball" and "Beatdown Elves" are both sub-archetypes of "Elves". A sub-archetype can belong to a Main archetype or another sub-archetype.

#### Archetype Conditions

An archetype is defined by a set of conditions. Each condition specifies a card and a minimum quantity (e.g., "at least 3 Llanowar Elves"). When a deck is loaded, the system evaluates it against all archetypes whose color identity is compatible with the deck.

#### Classification Algorithm

1. Filter candidate archetypes by color identity compatibility with the deck.
2. For each candidate, compute a match score: the number of conditions the deck satisfies divided by the total number of conditions for that archetype. Only mainboard cards are considered; the sideboard is excluded from matching.
3. If the match score meets or exceeds the archetype's configurable minimum match threshold (default 60%), the archetype is considered a match. Each archetype can have its own threshold, allowing stricter definitions for well-defined archetypes and looser ones for broader categories.
4. All passing archetypes are stored as deck classifications with their scores. Only archetypes that pass the threshold are stored; failed matches are discarded.
5. The best match is assigned to the deck:
   - If a sub-archetype matches, it is assigned (its parent is implied and can be navigated).
   - If only a main archetype matches, it is assigned directly.
   - If multiple archetypes tie for the highest score, the deck is marked with a TIE classification status for manual resolution.
6. Classification status tracks how the assignment was made: AUTO (clear winner), TIE (needs review), MANUAL (user override), or UNCLASSIFIED (nothing matched).

### Events and Games

The league is organized into events. Each event has a name, start date, and optional end date. Games are recorded within events, linking two decks and their results. Game status tracks the lifecycle of a match report: pending, completed, rejected, or deleted.

## Tech Stack

- **API**: Node.js with Express.js and TypeScript
- **Database**: PostgreSQL with Prisma ORM
- **Frontend**: React with Vite and TypeScript
- **Architecture**: Monorepo with `api/` and `web/` workspaces

## Data Model

```
User
 +-- Deck
      +-- DeckListRecord (card, amount, board)
      +-- DeckClassification (archetype, matchScore)

Card
 +-- DeckListRecord
 +-- ArchetypeCondition

Archetype
 +-- ArchetypeCondition (card, minAmount)
 +-- Archetype (sub-archetypes, self-referential)
 +-- DeckClassification

Event
 +-- Game (deck1, deck2, results)
```

## Project Structure

```
pauper/
  api/
    prisma/          -- Schema and migrations
    src/
      lib/           -- Shared utilities (error handling, Result types, branded strings)
      card-library/  -- Card search and retrieval
      repositories/  -- Data access layer
      managers/      -- Business logic and orchestration
  web/
    src/             -- React frontend
```

## Scripts

| Command | Description |
|---------|-------------|
| `npm run api` | Start API dev server |
| `npm run web` | Start frontend dev server |
| `npm run db:migrate` | Run Prisma migrations |
| `npm run db:generate` | Regenerate Prisma client |
| `npm run db:studio` | Open Prisma Studio |
