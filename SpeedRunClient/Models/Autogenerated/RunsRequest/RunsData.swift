/* 
Copyright (c) 2019 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct RunsData : Codable {
	let id : String?
	let weblink : String?
	let game : String?
	let category : String?
	let videos : Videos?
	let players : [Players]?
	let date : String?
	let submitted : String?
	let times : Times?
	let system : System?
	let links : [Links]?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case weblink = "weblink"
		case game = "game"
		case category = "category"
		case videos = "videos"
		case players = "players"
		case date = "date"
		case submitted = "submitted"
		case times = "times"
		case system = "system"
		case links = "links"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(String.self, forKey: .id)
		weblink = try values.decodeIfPresent(String.self, forKey: .weblink)
		game = try values.decodeIfPresent(String.self, forKey: .game)
		category = try values.decodeIfPresent(String.self, forKey: .category)
		videos = try values.decodeIfPresent(Videos.self, forKey: .videos)
		players = try values.decodeIfPresent([Players].self, forKey: .players)
		date = try values.decodeIfPresent(String.self, forKey: .date)
		submitted = try values.decodeIfPresent(String.self, forKey: .submitted)
		times = try values.decodeIfPresent(Times.self, forKey: .times)
		system = try values.decodeIfPresent(System.self, forKey: .system)
		links = try values.decodeIfPresent([Links].self, forKey: .links)
	}

}
