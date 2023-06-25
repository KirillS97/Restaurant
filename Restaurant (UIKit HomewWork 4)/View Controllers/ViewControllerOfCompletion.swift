import UIKit

class ViewControllerOfCompletion: UIViewController {
    
    
    
    var completionImageView: UIImageView!
    var textLabel: UILabel!
    var closureForCompleteThisOrder: (() -> Void)?
    
    
    
    // MARK: - "viewDidLoad" method
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // MARK: Настройка корневогого "View"
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        self.view.backgroundColor = viewColor
        
        let widthOfRootView = self.view.frame.width
        let heightOfRootView = self.view.frame.height
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Настройка изображения
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        // Инициализация объекта
        let image = UIImage(named: "completedOrder.png")!.scaleImage(targetWidth: (widthOfRootView * 0.7),
                                                                     targetHeight: nil)
        self.completionImageView = UIImageView(image: image)
        
        // Добавление объекта изображения к корневому "View"
        self.view.addSubview(self.completionImageView)
        
        // Отключение системных ограничений
        self.completionImageView.translatesAutoresizingMaskIntoConstraints = false
        
        // Позиционирование объекта изображения на сцене с помощью ограничений
        NSLayoutConstraint.activate([
            self.completionImageView.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            self.completionImageView.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor,
                                                              constant: -100)
        ])
        
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: текстовой метки
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        // Инициализация объекта
        self.textLabel = UILabel()
        
        // Настройка внешнего вида метки
        createLabel(rootView: self.view,
                    label: self.textLabel,
                    text: "Заказ создан!",
                    fontSize: (heightOfRootView * labelTitleFontSizeFactor),
                    fontWeight: .thin,
                    isCenterTextAlignment: true)
        
        // Добавление метки на родительский вью
        self.view.addSubview(self.textLabel)
        
        // Отключение автоматических ограничений
        self.textLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Позиционирование объекта метки на сцене с помощью ограничений
        NSLayoutConstraint.activate([
            self.textLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.textLabel.topAnchor.constraint(equalTo: self.completionImageView.bottomAnchor, constant:
                                                    (50 * heightOfRootView / iPhone14SceneHeight)
                                                 )
        ])
        
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
    }
    
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    
    
    // MARK: - "viewWillDisappear" method
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.closureForCompleteThisOrder!()
    }
    
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    
}
