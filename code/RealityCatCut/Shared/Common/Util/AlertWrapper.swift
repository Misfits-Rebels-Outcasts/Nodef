//
//  AlertWrapper.swift
//  SketchEffects


import SwiftUI
import Combine
//https://stackoverflow.com/questions/56726663/how-to-add-a-textfield-to-alert-in-swiftui
class TextFieldAlertViewController: UIViewController {

  /// Presents a UIAlertController (alert style) with a UITextField and a `Done` button
  /// - Parameters:
  ///   - title: to be used as title of the UIAlertController
  ///   - message: to be used as optional message of the UIAlertController
  ///   - text: binding for the text typed into the UITextField
  ///   - isPresented: binding to be set to false when the alert is dismissed (`Done` button tapped)
    init(title: String, message: String?, labelContent: String, text: Binding<String?>, isPresented: Binding<Bool>?, saveSuccess: Binding<Bool>?, existingLabelExist: Binding<Bool>?, alertMessage: Binding<String?>) {
    self.alertTitle = title
    self.message = message
        self.labelContent = labelContent
    self._text = text
    self.isPresented = isPresented
        self.saveSuccess = saveSuccess
        self.existingLabelExist = existingLabelExist
        self._alertMessage = alertMessage

    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Dependencies
  private let alertTitle: String
  private let message: String?
    private let labelContent: String
  @Binding private var text: String?
  private var isPresented: Binding<Bool>?
    private var saveSuccess: Binding<Bool>?
    private var existingLabelExist: Binding<Bool>?
    @Binding private var alertMessage: String?

  // MARK: - Private Properties
  private var subscription: AnyCancellable?

  // MARK: - Lifecycle
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    presentAlertController()
  }

  private func presentAlertController() {
    guard subscription == nil else { return } // present only once

    let vc = UIAlertController(title: alertTitle, message: message, preferredStyle: .alert)

    // add a textField and create a subscription to update the `text` binding
    vc.addTextField { [weak self] textField in
      guard let self = self else { return }
      self.subscription = NotificationCenter.default
        .publisher(for: UITextField.textDidChangeNotification, object: textField)
        .map { ($0.object as? UITextField)?.text }
        .assign(to: \.text, on: self)
    }

      let caction = UIAlertAction(title: "Cancel", style: .default) { [weak self] _ in
        self?.isPresented?.wrappedValue = false
          self?.saveSuccess?.wrappedValue = false
         
      }

    // create a `Done` action that updates the `isPresented` binding when tapped
    // this is just for Demo only but we should really inject
    // an array of buttons (with their title, style and tap handler)
    let action = UIAlertAction(title: "Save", style: .default) { [weak self] _ in
      self?.isPresented?.wrappedValue = false
      

        if self!.text != nil
        {
        
        }
        else
        {
            self?.saveSuccess?.wrappedValue = true //actually not success but reuse
           
            if appType=="B"
            {
                self?.alertMessage = Optional.some("Please enter a valid label name for saving.")
            }
            else{
                self?.alertMessage = Optional.some("Please enter a valid document name for saving.")
            }
            
            return
        }

        if self!.text! == ""
        {
            self?.saveSuccess?.wrappedValue = true //actually not success but reuse
            if appType=="B"
            {
                self?.alertMessage = Optional.some("Please enter a valid label name for saving.")
            }
            else{
                self?.alertMessage = Optional.some("Please enter a valid document name for saving.")
            }

            return
        }
        
        print("Saving:",self!.text!)
        
        let file = self!.text!
                
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {

            let fileURL = dir.appendingPathComponent(file)
            let fileManager = FileManager.default
            print(fileURL.path)
            print(file)
            
            if fileManager.fileExists(atPath: fileURL.path) {
                 print("FILE AVAILABLE")
                self?.saveSuccess?.wrappedValue = true
                if appType=="B"
                {
                    self?.alertMessage = Optional.some("An existing label with the same name already exist. Please enter another label name and try saving again.")
                }
                else{
                    self?.alertMessage = Optional.some("An existing document with the same name already exist. Please enter another label name and try saving again.")
                }
            } else {
                print("FILE NOT AVAILABLE")
                do {
                    try self!.labelContent.write(to: fileURL, atomically: false, encoding: .utf8)
                    self?.saveSuccess?.wrappedValue = true
                   
                    if appType=="B" 
                    {
                        self?.alertMessage = Optional.some("Label saved successfully.")
                    }
                    else{
                        self?.alertMessage = Optional.some("Document saved successfully.")
                    }
                }
                catch {
                    self?.text = Optional.some("")
                }
            }
            self?.text = Optional.some("")

        }
        
               
    }
      
      vc.addAction(caction)
    vc.addAction(action)
    present(vc, animated: true, completion: nil)
  }
}

struct TextFieldAlert {

  // MARK: Properties
  let title: String
  let message: String?
  let labelContent: String
  @Binding var text: String?
  var isPresented: Binding<Bool>? = nil
    var saveSuccess: Binding<Bool>? = nil
    var existingLabelExist: Binding<Bool>? = nil
  @Binding var  alertMessage: String?

  // MARK: Modifiers
  func dismissable(_ isPresented: Binding<Bool>) -> TextFieldAlert {
      TextFieldAlert(title: title, message: message,labelContent:labelContent, text: $text, isPresented: isPresented, saveSuccess: saveSuccess, existingLabelExist: existingLabelExist,alertMessage: $alertMessage)
  }
}

extension TextFieldAlert: UIViewControllerRepresentable {

  typealias UIViewControllerType = TextFieldAlertViewController

  func makeUIViewController(context: UIViewControllerRepresentableContext<TextFieldAlert>) -> UIViewControllerType {
      TextFieldAlertViewController(title: title, message: message, labelContent: labelContent, text: $text, isPresented: isPresented, saveSuccess: saveSuccess, existingLabelExist: existingLabelExist, alertMessage: $alertMessage)
  }

  func updateUIViewController(_ uiViewController: UIViewControllerType,
                              context: UIViewControllerRepresentableContext<TextFieldAlert>) {
    // no update needed
  }
}

struct TextFieldWrapper<PresentingView: View>: View {

  @Binding var isPresented: Bool
  let presentingView: PresentingView
  let content: () -> TextFieldAlert

  var body: some View {
    ZStack {
      if (isPresented) { content().dismissable($isPresented) }
      presentingView
    }
  }
}

extension View {
  func textFieldAlert(isPresented: Binding<Bool>,
                      content: @escaping () -> TextFieldAlert) -> some View {
    TextFieldWrapper(isPresented: isPresented,
                     presentingView: self,
                     content: content)
  }
}



