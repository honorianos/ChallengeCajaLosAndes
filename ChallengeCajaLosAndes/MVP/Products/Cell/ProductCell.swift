//
// Copyright (c) 2021 Related Code - https://relatedcode.com
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import UIKit

//-----------------------------------------------------------------------------------------------------------------------------------------------
class ProductCell: UITableViewCell {

	@IBOutlet var viewBackground: UIView!

	@IBOutlet var viewCard: UIView!
	@IBOutlet var imageCard: UIImageView!
	@IBOutlet var labelCardNumber: UILabel!
	@IBOutlet var labelExpiry: UILabel!
	@IBOutlet var labelName: UILabel!

	@IBOutlet var imageSelected: UIImageView!

	//-------------------------------------------------------------------------------------------------------------------------------------------
	override func awakeFromNib() {

		super.awakeFromNib()

		viewCard.layer.borderWidth = 1
		viewCard.layer.borderColor = AppColor.Border.cgColor
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func bindData(data: Card) {

        labelCardNumber.text = data.cardType + " " + data.cardNumber
        labelExpiry.text = data.expiry
        labelName.text = data.name
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func setCell(isSelected: Bool) {

		viewBackground.backgroundColor = isSelected ? UIColor.systemBackground : UIColor.tertiarySystemFill
		viewBackground.layer.borderWidth = isSelected ? 1 : 0
		viewBackground.layer.borderColor = isSelected ? AppColor.Theme.cgColor : UIColor.clear.cgColor
		imageSelected.isHighlighted = isSelected
		imageSelected.tintColor = isSelected ? AppColor.Theme : UIColor.systemGray
	}
}
