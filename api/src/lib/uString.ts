export class UString<T extends string> {
  constructor(readonly value: T) {}

  toString(): string {
    return this.value;
  }

  is(value: T): boolean {
    return this.value === value;
  }

  isNot(value: string): boolean {
    return this.value !== value;
  }

  isIn(values: string[]): boolean {
    return values.includes(this.value);
  }
}

export const uString = <T extends string>(value: T) => new UString(value);

export type BrandedString<B extends string> = { __brand: B; value: string; toString: () => string; toJSON: () => string };
export const brandedString = <B extends string>(value: string, brand: B) => ({
  __brand: brand,
  value,
  toString: () => value,
  toJSON: () => value,
});

export class BrandedUString<B extends string> extends UString<string> {
  readonly __brand: B;

  constructor(value: string, brand: B) {
    super(value);
    this.__brand = brand;
  }

  toJSON(): string {
    return this.value;
  }
}

export const brandedUString = <B extends string>(value: string, brand: B) => new BrandedUString(value, brand);


