require 'nylas'

api = Nylas::API.new(
  app_id: ENV['NYLAS_APP_ID'],
  app_secret: ENV['NYLAS_APP_SECRET']
  access_token: ENV['nylas_token']
)



account = nylas.current_account
puts(
    "Email: #{account.email_address} | " \
    "Provider: #{account.provider} | " \
    "Organization: #{account.organization_unit}"
)
# Account added for kanad642@gmail.com. Access token: XP8mJ0gWRkoXly1iLCNS0memgl3Dyk

puts ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> 1 <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
message = nylas.messages.first
puts(
    "Subject: #{message.subject} | "\
    "Unread: #{message.unread} | "\
    "From: #{message.from.first.email} | "\
    "ID: #{message.id} | "\
    )

puts ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> 2 <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"

# .threads returns all threads that have been synced to Nylas
threads = nylas.threads.limit(10) # Limit and offset can be used to control pagination
threads.each{ |thread|
    puts(
        "Subject: #{thread.subject} | "\
        "Participant: #{thread.participants.first.email} | "\
    )
}
puts ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> 3 <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
# Filter for the 5 most recent unread threads
threads = nylas.threads.where(unread: true).limit(5)
threads.each{ |thread|
    puts(thread.subject)
}
puts ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> 4 <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
# Search for the most recent email from a specific address
message = nylas.messages.search("from:vishal.pratik@gmail.com").first
puts(message.subject)
puts ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> 5 <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
# You can also search threads
thread = nylas.threads.search("to:vishal.pratik@gmail.com").first
puts(thread.subject)

puts ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> 6 <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"

nylas.send!(
    to: [{ email: 'kanad642@gmail.com', name: "Nylas" }],
    subject: "With Love, from Nylas",
    body: "This email was sent using the Nylas Email API. Visit https://nylas.com for details."
    ).to_h
puts ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> 7 <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
# message_id = 'a8v4hcwpx1ta5obe77eaxvhm9'
# message = nylas.messages.find(message_id)

# draft = nylas.drafts.create(
#     reply_to_message_id: message.id,
#     to: message.from,
#     body: "This is my reply."
# )
# draft.send!

puts ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> 8 <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"

# Most user accounts have multiple calendars where events are stored
calendars = nylas.calendars
calendars.each{ |calendar|
    # Print the name and description of each calendar and whether or not the calendar is read only
    puts(
        "Name: #{calendar.name} | "\
        "Description: #{calendar.description} | "\
        "Read Only: #{calendar.read_only}"
        )
}

# Pick a calendar to inspect.
# calendar = nylas.calendars.first()
# events = nylas.events.limit(5)
# events.each{ |event|
#     puts(
#         "Title: #{event.title} | "\
#         "When: #{event.when.start_time} | "\
#         "Partcipants: #{event.participants.first.name}"
#         )
# }

puts ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> 9 <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"

contact = nylas.contacts.create

# The contact's given name is typically their first name,
# you can specify a last name with 'surname'
contact.given_name = "My Nylas Friend"

# Phone number type must be one of 'business', 'organization_main',
# 'mobile', 'assistant', 'business_fax', 'home_fax', 'radio', 'car', 'home', or 'pager'
# Google labels 'business' phone numbers as the contact's Work phone number
contact.phone_numbers = [{type: 'business', number: '555 555-5555'}]

# Email address 'type' must be either 'work' or 'personal'
contact.emails = [{type: 'work', email: 'swag@nylas.com'}]
contact.notes = "Make sure to keep in Touch!"

# web_pages must be one of type homepage, profile, work, or blog
contact.web_pages = [{type: 'homepage', url: 'https://nylas.com'}]

contact.save

puts ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> 10 <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"

