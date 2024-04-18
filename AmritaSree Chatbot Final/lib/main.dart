import 'package:amritasree_chatbot/product.dart';
import 'package:flutter/material.dart';

// The entry point of the app
void main() {
  runApp(const ChatBotApp());
}

// The main app widget
class ChatBotApp extends StatelessWidget {
  const ChatBotApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Hide the debug banner
      home: const ChatScreen(), // Set the home screen to ChatScreen
      routes: {
        '/products': (context) => const Products(), // Define a route for the Products screen
      },
    );
  }
}

// The chat screen widget
class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<ChatMessage> messages = [];
  List<OptionData> botOptions = [];
  final scrollController = ScrollController();
  List<List<OptionData>?> optionHistory = [null];
  bool isOptionsOpen = true;
  String sectionTitle = "Options";

  @override
  void initState() {
    super.initState();
    addBotMessage("Hello to the Amritasree Chatbot User17",
        isInitialGreeting: true);
    Future.delayed(const Duration(seconds: 1), () {
      addBotMessage("How can I assist you today? ", isFollowUpGreeting: true);
      setBotOptions([
        OptionData(text: "Help & Support", iconPath: "assets/support.png"),
        OptionData(text: "Advertisement", iconPath: "assets/ad.png"),
      ]);
    });
  }

  // Add a bot message
  void addBotMessage(String text,
      {bool isInitialGreeting = false, bool isFollowUpGreeting = false}) {
    setState(() {
      messages.add(ChatMessage(
        text,
        MessageType.bot,
        isInitialGreeting: isInitialGreeting,
        isFollowUpGreeting: isFollowUpGreeting,
      ));
    });
  }

  // Add a user message
  void addUserMessage(String text) {
    setState(() {
      messages.add(ChatMessage(text, MessageType.user));
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    });
  }

  // Set the bot options
  void setBotOptions(List<OptionData> options) {
    setState(() {
      botOptions = options;
    });
  }

  // Handle the selection of a bot option
  void handleOptionSelected(OptionData option) {
    optionHistory.add(List<OptionData>.from(botOptions));

    switch (option.text) {
      case "Help & Support":
        addUserMessage("Help and Support");
        addBotMessage(
            "Sure, I can help you with that. What kind of support do you need?");
        setBotOptions([
          OptionData(text: "Check Balance", iconPath: "assets/bal.png"),
          OptionData(text: "Transactions", iconPath: "assets/transactions.png"),
          OptionData(text: "Pending Loans", iconPath: "assets/loan.png"),
          OptionData(text: "More Options", iconPath: "assets/other.png"),
        ]);
        sectionTitle = "Help and Support";
        break;
      case "Advertisement":
        addUserMessage("Advertisement");
        addBotMessage("Great! What would you like to do with advertisements?");
        setBotOptions([
          OptionData(
              text: "Publish an Advertisement", iconPath: "assets/publish.png"),
          OptionData(text: "AmritaSree Products", iconPath: "assets/rating.png"),
        ]);
        sectionTitle = "Advertisement";
        break;
      case "Check Balance":
        addUserMessage("App Balance");
        addBotMessage("Your current balance is 1000.");
        break;
      case "Transactions":
        addUserMessage("Transactions");
        addBotMessage("You have no recent transactions.");
        break;
      case "Pending Loans":
        addUserMessage("Pending Loans");
        addBotMessage("Your loans are all clear.");
        break;
      case "More Options":
        addUserMessage("More Options");
        addBotMessage("Here are more options for you. Please select one.");
        setBotOptions([
          OptionData(text: "Account Information", iconPath: "assets/user1.png"),
          OptionData(text: " Group Information ", iconPath: "assets/group.png"),
          OptionData(
              text: "Cluster Information", iconPath: "assets/cluster.png"),
          OptionData(
              text: "Back to Main Menu", iconPath: "assets/mainmenu.png"),
        ]);
        sectionTitle = "More Options";
        break;
      case "Account Information":
        addUserMessage("Account Information");
        addBotMessage(
            "To access your account information, please provide your account details.");
        break;
      case " Group Information ":
        addUserMessage("Group Information");
        addBotMessage(
            "Group information can be provided. What specific group are you interested in?");
        break;
      case "Cluster Information":
        addUserMessage("Cluster Information");
        addBotMessage("Enter your Cluster Login details.");
        break;
      case "Back to Main Menu":
        handleMainMenuItemClick();
        addBotMessage("Back to the main menu. How can I assist you further?");
        break;
      case "Go Back to Main Menu":
        addUserMessage("Go Back to Main Menu");
        setBotOptions([
          OptionData(text: "Help & Support", iconPath: "assets/support.png"),
          OptionData(text: "AmritaSree Products", iconPath: "assets/rating.png"),
        ]);
        sectionTitle = "Options";
        break;
      case "Publish an Advertisement":
        addUserMessage("Publish an Advertisement");
        addBotMessage("Sure! Please provide the details.");
        break;
      case "AmritaSree Products":
        addUserMessage("Product Rating");
        Navigator.pushNamed(context, '/products');
        break;
    }
  }

  // Handle the click on the main menu item
  void handleMainMenuItemClick() {
    addUserMessage("Main Menu");
    setBotOptions([
      OptionData(text: "Help & Support", iconPath: "assets/support.png"),
      OptionData(text: "Advertisement", iconPath: "assets/ad.png"),
    ]);
    sectionTitle = "Options";
  }

  // Handle the back button press
  void handleBackButtonPressed() {
    if (optionHistory.length > 1) {
      optionHistory.removeLast(); // Remove the last bot options from the history
      List<OptionData>? previousOptions = optionHistory.last;
      if (previousOptions != null) {
        setBotOptions(previousOptions);
      } else {
        setBotOptions([
          // Set the default bot options
          OptionData(text: "Help & Support", iconPath: "assets/support.png"),
          OptionData(text: "Advertisement", iconPath: "assets/ad.png"),
        ]);
        optionHistory = [null];
        sectionTitle = "Options";
      }
    }
  }

  // Toggle the options
  void toggleOptions() {
    setState(() {
      isOptionsOpen = !isOptionsOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: optionHistory.length > 1
            ? IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                color: const Color(0xFF0B0000),
                onPressed:
                    handleBackButtonPressed, // Handle the back button press
              )
            : null,
        title: const Text(
          'SUPPORT', // Set the app bar title
          style: TextStyle(
            fontFamily: 'Monsterrat',
            fontWeight: FontWeight.w400,
            fontSize: 21,
            color: Color(0xFF0B0000),
            letterSpacing: 2,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 20, 10),
            child: ElevatedButton(
              onPressed: () {}, // Handle the button press
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    const Color.fromARGB(255, 255, 255, 255)),
                minimumSize: MaterialStateProperty.all(const Size(47, 47)),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(
                      width: 0,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ),
              ),
              child: const Icon(
                Icons.translate,
                color: Color.fromARGB(255, 4, 4, 4),
                size: 35,
              ),
            ),
          ),
        ],
        centerTitle: true,
        elevation: 4,
      ),

      //Body Start
      body: Container(
        decoration: const BoxDecoration(),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return messages[index];
                },
              ),
            ),
            GestureDetector(
              onTap: toggleOptions,
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                  color: Color.fromRGBO(234, 221, 255, 1),
                ),
                padding: const EdgeInsets.all(5.0),
                child: isOptionsOpen
                    ? const Icon(Icons.keyboard_arrow_up)
                    : const Icon(Icons.keyboard_double_arrow_down_rounded),
              ),
            ),
            if (isOptionsOpen)
              BotOptionsWidget(
                options: botOptions, // Pass the bot options to the widget
                onOptionSelected: handleOptionSelected,
                onBackButtonPressed: handleBackButtonPressed,
                screenWidth: screenWidth,
                sectionTitle: sectionTitle,
              ),
          ],
        ),
      ),
    );
  }
}

// The message type enum
enum MessageType { user, bot }

// The chat message widget
class ChatMessage extends StatelessWidget {
  final String text;
  final MessageType type;
  final bool isInitialGreeting;
  final bool isFollowUpGreeting;

  const ChatMessage(
    this.text,
    this.type, {
    super.key,
    this.isInitialGreeting = false,
    this.isFollowUpGreeting = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isInitialGreeting) {
      return _buildInitialGreetingMessage(text, type);
    } else if (isFollowUpGreeting) {
      return _buildFollowUpGreetingMessage(text, type);
    } else {
      return _buildRegularMessage(text, type);
    }
  }

  //Widget function for the first greeting message
  Widget _buildInitialGreetingMessage(String text, MessageType type) {
    return Align(
      alignment: type == MessageType.user
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(13, 45, 1, 0),
        child: Container(
          padding: const EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            borderRadius: type == MessageType.bot
                ? const BorderRadius.only(
                    topLeft: Radius.circular(21.0),
                    topRight: Radius.circular(21.0),
                    bottomLeft: Radius.circular(21.0),
                    bottomRight: Radius.circular(21.0))
                : BorderRadius.circular(1.0),
            color: const Color(0xFF6854A4),
          ),
          child: RichText(
            text: const TextSpan(
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w500,
                fontFamily: 'OpenSans',
              ),
              children: <TextSpan>[
                TextSpan(
                    text: "Welcome to the ",
                    style: TextStyle(fontWeight: FontWeight.normal)),
                TextSpan(
                    text: "AmritaSree ChatBot user#17.",
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget function for the followup greeting message
  Widget _buildFollowUpGreetingMessage(String text, MessageType type) {
    return Align(
      alignment: type == MessageType.user
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(13, 3, 100, 0),
        child: Container(
          padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
          decoration: BoxDecoration(
            borderRadius: type == MessageType.bot
                ? const BorderRadius.only(
                    bottomLeft: Radius.circular(21.0),
                    bottomRight: Radius.circular(21.0),
                    topLeft: Radius.circular(21.0),
                    topRight: Radius.circular(21.0))
                : BorderRadius.circular(21.0),
            color: const Color(0xFF6854A4),
          ),
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w400,
              fontFamily: 'OpenSans',
            ),
          ),
        ),
      ),
    );
  }

  //Widget function for messages from the user side
  Widget _buildRegularMessage(String text, MessageType type) {
    return Align(
      alignment: type == MessageType.user
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
        child: Container(
          padding: const EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(21.0),
            color: type == MessageType.user
                ? const Color.fromRGBO(156, 91, 220, 1)
                : const Color.fromRGBO(104, 84, 164, 1),
          ),
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w400,
              fontFamily: 'OpenSans',
            ),
          ),
        ),
      ),
    );
  }
}

// The bot options widget
class BotOptionsWidget extends StatelessWidget {
  final List<OptionData> options;
  final Function(OptionData) onOptionSelected;
  final Function() onBackButtonPressed;
  final double screenWidth;
  final String sectionTitle;

  const BotOptionsWidget({
    super.key,
    required this.options,
    required this.onOptionSelected,
    required this.onBackButtonPressed,
    required this.screenWidth,
    required this.sectionTitle,
  });

  // Navigation bar containing chatbot options
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        color: Color.fromRGBO(234, 221, 255, 1),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: ElevatedButton(
                  onPressed: onBackButtonPressed,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red),
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.fromLTRB(10, 10, 5, 10)),
                  ),
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Wrap(
            spacing: 20.0,
            runSpacing: 15.0,
            alignment: WrapAlignment.center,
            children: options.map((option) {
              return SizedBox(
                width: 161,
                // height: 158,
                child: ElevatedButton(
                  onPressed: () {
                    onOptionSelected(option);
                  },
                  style: ButtonStyle(
                    padding:
                        MaterialStateProperty.all(const EdgeInsets.all(16.0)),
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromRGBO(104, 84, 164, 1)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        option.iconPath,
                        height: screenWidth < 600 ? 40 : 60,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        option.text,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'OpenSans',
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class OptionData {
  final String text;
  final String iconPath;

  OptionData({
    required this.text,
    required this.iconPath,
  });
}
