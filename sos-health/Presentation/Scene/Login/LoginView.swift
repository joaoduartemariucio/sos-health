import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""

    @FocusState private var focusedField: Field?

    @ObservedObject var viewModel: ViewModel

    private enum Field { case email, password }

    private var canSubmit: Bool {
        !email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        email.contains("@") &&
        !password.isEmpty
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                Text("app_name")
                    .foregroundColor(.primary)
                    .font(.title)
                    .bold()

                Text("login_description")
                    .foregroundColor(.welcomeColor)
                    .font(.subheadline)

                TextField("text_field_email_place_holder", text: $email)
                    .underlineTextField()
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .textContentType(.username)
                    .focused($focusedField, equals: .email)
                    .submitLabel(.next)
                    .onSubmit { focusedField = .password }

                SecureField("text_field_password_place_holder", text: $password)
                    .underlineTextField()
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .textContentType(.password)
                    .focused($focusedField, equals: .password)
                    .submitLabel(.go)
                    .onSubmit { submit() }

                Button(action: forgotPassword) {
                    Text("button_forgot_password")
                        .font(.caption)
                        .bold()
                        .underline()
                }
                .frame(maxWidth: .infinity, alignment: .trailing)

                Spacer().frame(height: 26)

                RoundedRectangleButton(
                    title: "button_login",
                    backgroundColor: .primary,
                    action: submit
                )
                .frame(maxWidth: 226)
                .frame(maxWidth: .infinity, alignment: .center)
                .disabled(!canSubmit)
            }
            .padding(28)
        }
    }

    private func submit() {
        guard canSubmit else { return }
        viewModel.login(email: email, password: password)
    }

    private func forgotPassword() {
        // TODO: navegar para recuperação de senha
    }
}
