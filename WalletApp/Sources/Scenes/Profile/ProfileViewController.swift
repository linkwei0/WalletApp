//
//  ProfileViewController.swift
//  WalletApp
//

import UIKit
import AuthenticationServices

class ProfileViewController: BaseViewController {
  // MARK: - Properties
  private let emptyStateView = EmptyStateView()
  
  private let authButton = ASAuthorizationAppleIDButton()
  
  private let viewModel: ProfileViewModel
  
  // MARK: - Init
  init(viewModel: ProfileViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    viewModel.viewIsReady()
    
    if let emptyStateViewModel = viewModel.emptyStateViewModel {
      emptyStateView.configure(with: emptyStateViewModel)
    }
  }
  
  // MARK: - Setup
  private func setup() {
    setupEmptyStateView()
    setupAuthButton()
  }
  
  private func setupEmptyStateView() {
    view.addSubview(emptyStateView)
    emptyStateView.isHidden = false
    emptyStateView.snp.makeConstraints { make in
      make.centerY.equalToSuperview().offset(-60)
      make.leading.trailing.equalToSuperview().inset(16)
    }
  }
  
  private func setupAuthButton() {
    view.addSubview(authButton)
    authButton.addTarget(self, action: #selector(didTapAuthButton), for: .touchUpInside)
    authButton.snp.makeConstraints { make in
      make.top.equalTo(emptyStateView.snp.bottom).offset(16)
      make.leading.trailing.equalToSuperview().inset(120)
      make.height.equalTo(50)
    }
  }
  
  @objc private func didTapAuthButton() {
    let provider = ASAuthorizationAppleIDProvider()
    let request = provider.createRequest()
    request.requestedScopes = [.fullName, .email]
    
    let authController = ASAuthorizationController(authorizationRequests: [request])
    authController.delegate = self
    authController.presentationContextProvider = self
    authController.performRequests()
  }
}

// MARK: - ASAuthorizationControllerDelegate
extension ProfileViewController: ASAuthorizationControllerDelegate {
  func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
    print("Failed to auth with \(error)")
  }
  
  func authorizationController(controller: ASAuthorizationController,
                               didCompleteWithAuthorization authorization: ASAuthorization) {
    switch authorization.credential {
    case let credential as ASAuthorizationAppleIDCredential:
      let firstName = credential.fullName?.givenName
      let lastName = credential.fullName?.familyName
      let email = credential.email
    default:
      break
    }
  }
}

// MARK: - ASAuthorizationControllerPresentationContextProviding
extension ProfileViewController: ASAuthorizationControllerPresentationContextProviding {
  func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
    return view.window!
  }
}
