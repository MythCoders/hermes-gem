# frozen_string_literal: true

RSpec.shared_context :mail do
  let(:to) { [Faker::Internet.email] }
  let(:cc) { [Faker::Internet.email] }
  let(:bcc) { [Faker::Internet.email] }
  let(:mail_subject) { Faker::Cannabis.buzzword }
  let(:sender) { Faker::Internet.email }
  let(:content_type) { 'text/plain' }
  let(:text_body) { Faker::Lorem.sentence }
  let(:html_body) { "<p>#{text_body}</p>" }
  let(:body) { text_body }
  let(:mail) do
    Mail.new do |m|
      m.from sender
      m.to to
      m.cc cc
      m.bcc bcc
      m.subject mail_subject
      m.content_type content_type
      m.body body
    end
  end
  let(:messages_data) do
    {
      message:
          {
            to: to,
            cc: cc,
            bcc: bcc,
            subject: mail_subject,
            sender: sender,
            body: body,
            content_type: content_type
          }
    }
  end
end
