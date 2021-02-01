


import UIKit

class ContactUsVC: ParentViewController {

    
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var sendMessageTitle: UILabel!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var senderEmail: UITextField!
    @IBOutlet weak var messageDetails: UITextField!
    @IBOutlet weak var sendBtn: UIButton!
    
    @IBAction func sendMessageAction(_ sender: Any) {
        let content = self.messageDetails.text
        let email = self.email.text ?? ""
        let name = self.name.text ?? ""
        if content == "" {
            self.showAlert(title: "", message: "ادخل محتوى الرساله", shouldpop: false)

        }else{
            let parameters = [content, email, name, "contact"]
            sendMessage(updatedParameters: parameters as! [String], onSuccess: { (teams) in
                self.showAlert(title: "", message: "تم ارسال الرساله", shouldpop: false)
                self.messageDetails.text = ""
                self.senderEmail.text = ""
                self.name.text = ""

            }) { (errorMessage) in
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "اتصل بنا"
        
        menuBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        menuBtn.widthAnchor.constraint(equalToConstant: 40.0).isActive = true
        menuBtn.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        menuBtn.setImage(#imageLiteral(resourceName: "menu"), for: .normal)
        
        menuBtn.addTarget(self, action: #selector(self.openSideMenu), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: menuBtn)
        
        applyDesign()
    }
    
    func applyDesign(){
        email.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().normalFontSize)
        email.textColor = Color.darkText.value
        
        phone.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().normalFontSize)
        phone.textColor = Color.darkText.value
        
        sendMessageTitle.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().largeFontSize)
        sendMessageTitle.textColor = Color.darkText.value
        
        name.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().normalFontSize)
        name.textColor = Color.darkText.value
        
        senderEmail.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().normalFontSize)
        senderEmail.textColor = Color.darkText.value
        
        messageDetails.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().normalFontSize)
        messageDetails.textColor = Color.darkText.value
        
        
        sendBtn.setTitleColor(UIColor.white, for: .normal)
        sendBtn.layer.cornerRadius = 5
        sendBtn.titleLabel?.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().normalFontSize)
        
        
    }
    
    //Side Menu
    @objc func openSideMenu(_ sender: UIButton) {
        performSegue(withIdentifier: "openMenu", sender: nil)
    }
    
    
    func sendMessage(updatedParameters: [String], onSuccess: @escaping (String) -> Void, onFailure: @escaping (String?) -> Void ) -> Void
    {
        
        let url = Urls().sendMessage()
        
        let parameters:[String:Any] = [
            "content": updatedParameters[0],
            "user_email": updatedParameters[1],
            "user_name": updatedParameters[2],
            "type": updatedParameters[3],
            "lang": HelperMethods.getCurrentLanguage()
        ]
        
        ServiceManager.callAPI(url: url, method: .post, parameters: parameters, custumHeaders: nil) { (error, response) in
            
            if response != nil
            {
                let statusCode = response!["StatusCode"].intValue
                if statusCode == 1 {
                    let message = response!["Message"].stringValue
                    onSuccess(message)
                }else{
                    let message = response!["Message"].stringValue
                    onFailure(message)
                }
            }
            else
            {
                onFailure(error!.localizedDescription)
            }
        }
    }

}
