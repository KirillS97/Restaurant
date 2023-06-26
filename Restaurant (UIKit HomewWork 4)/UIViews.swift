import UIKit



// MARK: - Size of Root View

// MARK: Color setting
let viewColor = UIColor.systemGray6

// MARK: Размеры экрана iPhone 14
let iPhone14SceneWidth: CGFloat = 393
let iPhone14SceneHeight: CGFloat = 852
let iPhone14SceneDiagonal = pow(( pow(iPhone14SceneWidth, 2) + pow(iPhone14SceneHeight, 2) ), 1/2)

// MARK: - Buttons

// MARK: Size settings
let buttonHeight: CGFloat = 45
let buttonHeightFactor: CGFloat = (buttonHeight / iPhone14SceneHeight)  // Отношение высоты корневого вью к высоте кнопки
let buttonCornerRadiusFactor: CGFloat = (buttonHeightFactor / 4)  // Отношение коэффициента высоты кнопки к коэффициенту закругления

// MARK: Color settings
let buttonBackgroundColor: UIColor = .systemRed  // Цвет фона кнопки
let normalButtonTitleColor: UIColor = .white  // Цвет текста заголовка в нормальном состоянии кнопки
let highlightedButtonTitleColor: UIColor = .systemGray5  // Цвет текста заголовка нажатой кнопки

// MARK: Title font settings
let buttonFonitSize: CGFloat = 22.5
let buttonFontSizeFactor: CGFloat = (buttonFonitSize / iPhone14SceneDiagonal)  // Отношение размера шрифта к размеру диагонали экрана
let buttonFontWeight: UIFont.Weight = .semibold // "Вес" шрифта заголовка

// MARK: Function for button creation
func createButton(rootView: UIView,
                  button: UIButton,
                  title: String,
                  fontSize: CGFloat? = nil,
                  fontWeight: UIFont.Weight? = nil,
                  normalTitleColor: UIColor? = nil,
                  highlightedTitleColor: UIColor? = nil,
                  backgroundColor: UIColor? = nil,
                  cornerRadius: CGFloat? = nil,
                  height: CGFloat? = nil) {
    
    // Размеры корневого Вью
    let widthOfRootView = rootView.frame.width
    let heightOfRootView = rootView.frame.height
    let diagonalOfRootView = pow(( pow(widthOfRootView, 2) + pow(heightOfRootView, 2) ), 1/2)
    
    // Локальные переменные, где (l) - local
    var lFontSize: CGFloat
    var lFontWeight: UIFont.Weight
    var lNormalTitleColor: UIColor
    var lHighlightedTitleColor: UIColor
    var lBackgroundColor: UIColor
    var lCornerRadius: CGFloat
    var lButtonHeight: CGFloat
    
    // Настройка локальных переменных
    if fontSize != nil { lFontSize = fontSize! }
    else { lFontSize = diagonalOfRootView * buttonFontSizeFactor }
    
    if fontWeight != nil { lFontWeight = fontWeight! }
    else { lFontWeight = buttonFontWeight }
    
    if normalTitleColor != nil { lNormalTitleColor = normalTitleColor! }
    else { lNormalTitleColor = normalButtonTitleColor }
    
    if highlightedTitleColor != nil { lHighlightedTitleColor = highlightedTitleColor! }
    else { lHighlightedTitleColor = highlightedButtonTitleColor }
    
    if backgroundColor != nil { lBackgroundColor = backgroundColor! }
    else { lBackgroundColor = buttonBackgroundColor }
    
    if cornerRadius != nil { lCornerRadius = cornerRadius! }
    else { lCornerRadius = heightOfRootView * buttonCornerRadiusFactor }
    
    if height != nil { lButtonHeight = height! }
    else { lButtonHeight = heightOfRootView * buttonHeightFactor }
    
    //Настройка текста заголовка кнопки
    button.setTitle(title, for: .normal)
    button.titleLabel?.font = .systemFont(ofSize: lFontSize, weight: lFontWeight)
    button.setTitleColor(lNormalTitleColor, for: .normal)
    button.setTitleColor(lHighlightedTitleColor, for: .highlighted)
    
    // Настройка фона кнопки
    button.backgroundColor = lBackgroundColor
    button.layer.cornerRadius = lCornerRadius
    
    // Настройка высоты кнопки
    button.heightAnchor.constraint(equalToConstant: lButtonHeight).isActive = true
}



// MARK: - Labels

// MARK: Font settings
let labelTitleFontSize: CGFloat = 35
let labelRegularFontSize: CGFloat = 20
let labelTitleFontSizeFactor = (labelTitleFontSize / iPhone14SceneDiagonal) // Коэффициент высоты шрифта для заголовочных текстов
let labelRegularFontSizeFactor: CGFloat = (labelRegularFontSize / iPhone14SceneDiagonal) // Коэффициент высоты шрифта для обычных текстов
let labelFontWeight: UIFont.Weight = .regular // "Вес" шрифта для обычных текстов

// MARK: Color settings
let labelRegularTextColor: UIColor = .black // Цвет текста метки для обычных текстов
let labelNoticeTextColor: UIColor = .systemRed  // Цвет текста для предупредительной метки

// MARK: Label creating function
func createLabel(rootView: UIView,
                 label: UILabel,
                 text: String,
                 numberOfLines: Int? = nil,
                 fontSize: CGFloat? = nil,
                 fontWeight: UIFont.Weight? = nil,
                 textColor: UIColor? = nil,
                 isCenterTextAlignment: Bool) {
    
    // Размеры корневого Вью
    let widthOfRootView = rootView.frame.width
    let heightOfRootView = rootView.frame.height
    let diagonalOfRootView = pow(( pow(widthOfRootView, 2) + pow(heightOfRootView, 2) ), 1/2)
    
    // Локальные переменные, где (l) - local
    var lFontSize: CGFloat
    var lFontWeight: UIFont.Weight
    var lTextColor: UIColor
    var lNumberOfLines: Int
    
    // Настройка локальных переменных
    if fontSize != nil { lFontSize = fontSize! }
    else { lFontSize = diagonalOfRootView *  labelRegularFontSizeFactor }
    
    if fontWeight != nil { lFontWeight = fontWeight! }
    else { lFontWeight = labelFontWeight }
    
    if textColor != nil { lTextColor = textColor! }
    else { lTextColor = labelRegularTextColor }
    
    if numberOfLines != nil { lNumberOfLines = numberOfLines! }
    else { lNumberOfLines = 1 }
    
    label.text = text
    label.numberOfLines = lNumberOfLines
    if isCenterTextAlignment { label.textAlignment = .center }
    label.font = .systemFont(ofSize: lFontSize, weight: lFontWeight)
    label.textColor = lTextColor
    
}



// MARK: - Text fields

// MARK: Text settings
var textFieldFontSize: CGFloat = 17
var textFieldFontSizeFactor: CGFloat = (textFieldFontSize / iPhone14SceneDiagonal) // Коэффициенты высоты текста
var textFieldFontWeight: UIFont.Weight = .light

// MARK: Color settings
var textFieldTextColor: UIColor = .black
var textFieldColor: UIColor = viewColor

// MARK: Text field creating function
func createTextField(rootView: UIView,
                     textfield: UITextField,
                     placeholder: String?,
                     borderStyle: UITextField.BorderStyle,
                     fontSize: CGFloat? = nil,
                     fontWeight: UIFont.Weight? = nil,
                     textColor: UIColor? = nil,
                     backgroundColor: UIColor? = nil) {
    
    // Размеры корневого Вью
    let widthOfRootView = rootView.frame.width
    let heightOfRootView = rootView.frame.height
    let diagonalOfRootView = pow(( pow(widthOfRootView, 2) + pow(heightOfRootView, 2) ), 1/2)
    
    // Локальные переменные, где (l) - local
    var lFontSize: CGFloat
    var lFontWeight: UIFont.Weight
    var lTextColor: UIColor
    var lbackgroundColor: UIColor
    
    // Настройка локальных переменных
    if fontSize != nil { lFontSize = fontSize! }
    else { lFontSize = textFieldFontSizeFactor * diagonalOfRootView }
    
    if fontWeight != nil { lFontWeight = fontWeight! }
    else { lFontWeight = textFieldFontWeight }
    
    if textColor != nil { lTextColor = textColor! }
    else { lTextColor = textFieldTextColor }
    
    if backgroundColor != nil { lbackgroundColor = backgroundColor! }
    else { lbackgroundColor = textFieldColor }
    
    // Настройка текста
    textfield.placeholder = placeholder
    textfield.textColor = lTextColor
    textfield.font = .systemFont(ofSize: lFontSize, weight: lFontWeight)
    
    // Настройка цвета
    textfield.borderStyle = borderStyle
    textfield.backgroundColor = lbackgroundColor
    
    // Отключение автоматического написания первого символа заглавной буквой
    textfield.autocapitalizationType = .none
    
}

