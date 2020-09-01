# frozen_string_literal: true

RSpec.shared_context :mail do
  let(:to) { [Faker::Internet.email] }
  let(:cc) { [Faker::Internet.email] }
  let(:bcc) { [Faker::Internet.email] }
  let(:mail_subject) { Faker::Cannabis.buzzword }
  let(:sender) { Faker::Internet.email }
  let(:text_body) { Faker::Lorem.sentence }
  let(:html_body) { "<p>#{text_body}</p>" }
  let(:body) { text_body }
  let(:mail) do
    m = Mail.new do |p|
      p.from sender
      p.to to
      p.cc cc
      p.bcc bcc
      p.subject mail_subject
    end

    m.text_part do |p|
      p.body text_body
    end

    m.html_part do |p|
      p.content_type 'text/html; charset=UTF-8'
      p.body html_body
    end

    m
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
            html_body: html_body,
            text_body: text_body
          }
    }
  end
end
