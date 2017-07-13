import UIKit

class DayCellView: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var sideDotView: UIView!
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var remainingTaskLabel: UILabel!
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    
    func setupView() {
        Bundle.main.loadNibNamed("DayCellView", owner: self, options: nil)
        addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        contentView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        sideDotView.layer.cornerRadius = 10
        sideDotView.layer.masksToBounds = true
        cellView.layer.cornerRadius = 10
        cellView.layer.masksToBounds = false
        cellView.layer.shadowOffset = CGSize(width: 0, height: 4)
        cellView.layer.shadowRadius = 3
        cellView.layer.shadowOpacity = 0.3
        cellView.layer.shadowColor = UIColor.gray.cgColor
    }
    
}
