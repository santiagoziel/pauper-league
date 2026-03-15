class Success<A> {
    constructor(public a:A){}
    ifThatFailsTry = (f:() => A) => this
    ifAllFails = (_: A) => this.a
}

class Failure<A>{
    constructor(public error: unknown){}
    ifThatFailsTry = (f:() => A) => tryTo(f)
    ifAllFails = (a: A) =>  a
}

type Attempt<A>= Success<A> | Failure<A>

const tryTo = <A>(f: () => A): Attempt<A> => {
    try{
        const a = f()
        return new Success(a)
    } catch(e) {
        return new Failure<A>(e)
    }
}

const f = (): string => {
    throw new Error("jsdnk")
}

const g = () => {
    return "done"
}

const stringAttempt = tryTo(f).ifThatFailsTry(g)