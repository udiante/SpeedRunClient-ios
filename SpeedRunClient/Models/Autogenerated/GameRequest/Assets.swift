/* 
Copyright (c) 2019 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Assets : Codable {
	let logo : ImageAsset?
	let coverTiny : ImageAsset?
	let coverSmall : ImageAsset?
	let coverMedium : ImageAsset?
	let coverLarge : ImageAsset?
	let icon : ImageAsset?
	let background : ImageAsset?
	let foreground : ImageAsset?

	enum CodingKeys: String, CodingKey {

		case logo = "logo"
		case coverTiny = "cover-tiny"
		case coverSmall = "cover-small"
		case coverMedium = "cover-medium"
		case coverLarge = "cover-large"
		case icon = "icon"
		case background = "background"
		case foreground = "foreground"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		logo = try values.decodeIfPresent(ImageAsset.self, forKey: .logo)
		coverTiny = try values.decodeIfPresent(ImageAsset.self, forKey: .coverTiny)
		coverSmall = try values.decodeIfPresent(ImageAsset.self, forKey: .coverSmall)
		coverMedium = try values.decodeIfPresent(ImageAsset.self, forKey: .coverMedium)
		coverLarge = try values.decodeIfPresent(ImageAsset.self, forKey: .coverLarge)
		icon = try values.decodeIfPresent(ImageAsset.self, forKey: .icon)
		background = try values.decodeIfPresent(ImageAsset.self, forKey: .background)
		foreground = try values.decodeIfPresent(ImageAsset.self, forKey: .foreground)
	}

}
