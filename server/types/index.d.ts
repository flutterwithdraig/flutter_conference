export {}

declare global {
    namespace Express {
        interface Request{
            uid: string | null,
            admin: boolean
        }
    }
}