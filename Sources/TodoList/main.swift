import KituraRouter
import KituraNet
import KituraSys
///
/// The Kitura router
///
let router = Router()

///
/// Setup the database
///
let todos: TodoCollection = TodoCollectionArray()

///
/// Listen to port 8090
///
let server = HttpServer.listen(8090, delegate: router)
 
Server.run()
