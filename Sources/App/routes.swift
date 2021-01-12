import Fluent
import Vapor

struct InfoData : Content{
    let name : String
}

struct InfoResponse : Content{
    let request : InfoData
}

func routes(_ app: Application) throws {
    app.get { req in
        return req.view.render("index", ["title": "Hello Vapor!"])
    }

    app.get("hello") { req -> String in
        return "Hello, world!"
    }

    app.get("hello", ":name") { req -> String in
        guard let name = req.parameters.get("name") else{
            throw Abort(.internalServerError)
        }
        return "Hello, \(name)"
    }
    
    app.post("info") { req -> InfoResponse in
        let data = try req.content.decode(InfoData.self)
        return InfoResponse(request: data)
    }
    
    try app.register(collection: TodoController())
}
