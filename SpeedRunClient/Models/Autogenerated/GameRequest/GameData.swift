/* 
Copyright (c) 2019 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct GameData : Codable {
	let id : String?
	let names : Names?
	let abbreviation : String?
	let weblink : String?
	let released : Int?
	let releaseDate : String?
	let romhack : Bool?
	let created : String?
	let assets : Assets?
	let links : [Links]?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case names = "names"
		case abbreviation = "abbreviation"
		case weblink = "weblink"
		case released = "released"
		case releaseDate = "release-date"
		case romhack = "romhack"
		case created = "created"
		case assets = "assets"
		case links = "links"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(String.self, forKey: .id)
		names = try values.decodeIfPresent(Names.self, forKey: .names)
		abbreviation = try values.decodeIfPresent(String.self, forKey: .abbreviation)
		weblink = try values.decodeIfPresent(String.self, forKey: .weblink)
		released = try values.decodeIfPresent(Int.self, forKey: .released)
		releaseDate = try values.decodeIfPresent(String.self, forKey: .releaseDate)
		romhack = try values.decodeIfPresent(Bool.self, forKey: .romhack)
		created = try values.decodeIfPresent(String.self, forKey: .created)
		assets = try values.decodeIfPresent(Assets.self, forKey: .assets)
		links = try values.decodeIfPresent([Links].self, forKey: .links)
	}

}
