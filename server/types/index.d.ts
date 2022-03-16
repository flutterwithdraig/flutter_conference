export {}

declare global {
    namespace Express {
        interface Request{
            uid: String | null
        }
    }
}