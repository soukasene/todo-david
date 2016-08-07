///
///Call a helper function to create routes in App.swift
///
setupRoutes( router, todos: todos )

.
router.use("/*", middleware: BodyParser())


router.get("/") {
   request, response, next in
 
    let json = JSON(TodoCollectionArray.serialize(todos.getAll()))
 
    response.status(HttpStatusCode.OK).sendJson(json)
 
    next()
}
///
/// Add a to-do list item
///
router.post("/") {
    request, response, next in
 
    if let body = request.body {
 
            if let json = body.asJson() {
 
                let title = json["title"].stringValue
                let order = json["order"].intValue
                let completed = json["completed"].boolValue
 
                let newItem = todos.add(title, order: order, completed: completed)
 
                let result = JSON(newItem.serialize())
 
                response.status(HttpStatusCode.OK).sendJson(result)
 
            }
        } else {
            Log.warning("No body")
            response.status(HttpStatusCode.BAD_REQUEST)
        }
 
}

class AllRemoteOriginMiddleware: RouterMiddleware {
    func handle(request: RouterRequest, response: RouterResponse, next: () -> Void) {
        response.setHeader("Access-Control-Allow-Origin", value: "*")
        response.setHeader("Access-Control-Allow-Headers", value: "accept, content-type")
        response.setHeader("Access-Control-Allow-Methods", value: "GET,HEAD,POST,DELETE,OPTIONS,PUT")
        next()
    }
}
 
router.use("/*", middleware: AllRemoteOriginMiddleware())
