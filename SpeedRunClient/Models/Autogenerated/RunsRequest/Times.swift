/* 
Copyright (c) 2019 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Times : Codable {
	let primary : String?
	let primary_t : Int?
	let realtime : String?
	let realtime_t : Int?
	let realtime_noloads : Int?
	let realtime_noloads_t : Int?
	let ingame : Int?
	let ingame_t : Int?

	enum CodingKeys: String, CodingKey {

		case primary = "primary"
		case primary_t = "primary_t"
		case realtime = "realtime"
		case realtime_t = "realtime_t"
		case realtime_noloads = "realtime_noloads"
		case realtime_noloads_t = "realtime_noloads_t"
		case ingame = "ingame"
		case ingame_t = "ingame_t"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		primary = try values.decodeIfPresent(String.self, forKey: .primary)
		primary_t = try values.decodeIfPresent(Int.self, forKey: .primary_t)
		realtime = try values.decodeIfPresent(String.self, forKey: .realtime)
		realtime_t = try values.decodeIfPresent(Int.self, forKey: .realtime_t)
		realtime_noloads = try values.decodeIfPresent(Int.self, forKey: .realtime_noloads)
		realtime_noloads_t = try values.decodeIfPresent(Int.self, forKey: .realtime_noloads_t)
		ingame = try values.decodeIfPresent(Int.self, forKey: .ingame)
		ingame_t = try values.decodeIfPresent(Int.self, forKey: .ingame_t)
	}

}