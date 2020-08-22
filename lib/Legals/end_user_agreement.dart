import 'package:flutter/material.dart';
import 'package:oracle/shared/constants.dart';

class EndUserAgreement extends StatefulWidget {
  @override
  _EndUserAgreementState createState() => _EndUserAgreementState();
}

class _EndUserAgreementState extends State<EndUserAgreement> {

  static const double textPadding = 8;
  static const double bulletPointLeftPadding = 10;
  static const double textSize = 15;
  static const TextStyle titleStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: textSize);
  static const TextStyle normalStyle = TextStyle(fontSize: textSize);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('End User Agreement'), backgroundColor: mainColor,),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: textPadding),
                    child: Text("Welcome to Cheethamiq’s User Agreement", style: titleStyle,),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: textPadding),
                    child: Text("PLEASE READ THESE LICENCE TERMS CAREFULLY", style: titleStyle,),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: textPadding),
                    child: Text("BY CLICKING ON THE “ACCEPT” BUTTON BELOW YOU AGREE TO THESE TERMS WHICH WILL BIND YOU.", style: normalStyle,),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: textPadding),
                    child: Text("IF YOU DO NOT AGREE TO THESE TERMS, CLICK ON THE “REJECT” BUTTON BELOW.", style: normalStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: textPadding),
                    child: Text("Who we are and what this agreement does", style: titleStyle,),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: textPadding/2),
                    child: Text("We Cheethamiq Ltd (hereinafter “We”, “Our” or Us”) Ltd of 55 The Links, Gwernaffield, Mold, Wales, CH7 5DZ license you to use:", style: normalStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: textPadding, left: bulletPointLeftPadding),
                    child: Text(String.fromCharCode(0x2022) + "	Cheethamiq mobile application software, the data supplied with the software, (App) and any updates or supplements to it.", style: normalStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: textPadding, left: bulletPointLeftPadding),
                    child: Text(String.fromCharCode(0x2022) + "	The related electronic documentation (Documentation).", style: normalStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: textPadding, left: bulletPointLeftPadding),
                    child: Text(String.fromCharCode(0x2022) + "	The service you connect to via the App and the content We provide to you through it (Service).", style: normalStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: textPadding),
                    child: Text("as permitted in these terms.", style: normalStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: textPadding),
                    child: Text("Your privacy", style:titleStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: textPadding),
                    child: Text("Under data protection legislation, We are required to provide you with certain information about who We are, how We process your personal data and for what purposes and your rights in relation to your personal data and how to exercise them. This information is provided in our privacy policy. ", style: normalStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: textPadding),
                    child: Text("Please be aware that internet transmissions are never completely private or secure and that any message or information you send using the App or any Service may be read or intercepted by others, even if there is a special notice that a particular transmission is encrypted.  Apple App Store and Play App Store’s terms also apply", style: normalStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: textPadding),
                    child: Text("The ways in which you can use the App and Documentation may also be controlled by the Apple App Store and Play App Store's rules and policies and their rules and policies will apply instead of these terms where there are differences between the two.", style: normalStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: textPadding),
                    child: Text("Operating system requirements", style: titleStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: textPadding),
                    child: Text("This app requires an iPhone or Android device with a minimum of 30mb of memory and IOS8 or 4.1 /Jellybean operating systems. ", style: normalStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: textPadding),
                    child: Text("Support for the App and how to tell Us about problems", style: titleStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: textPadding),
                    child: Text("Support. If you want to learn more about the App or the Service or have any problems using them please take a look at Our support resources on the App.", style: normalStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: textPadding),
                    child: Text("Contacting Us (including with complaints). If you think the App or the Services are faulty or misdescribed or wish to contact Us for any other reason please email Our customer service team at cheethamIQ@gmail.com. ", style: normalStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: textPadding),
                    child: Text("How We will communicate with you. If We have to contact you We will do so via the App, by email, by SMS or using the contact details you have provided to Us.", style: normalStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: textPadding),
                    child: Text("How you may use the App, including how many devices you may use it on", style: titleStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: textPadding),
                    child: Text("In return for your agreeing to comply with these terms you may:", style: normalStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: textPadding, left: bulletPointLeftPadding),
                    child: Text(String.fromCharCode(0x2022) + "	download or stream a copy of the App onto multiple device and view, use and display the App and the Service on such devices for your personal purposes only;", style: normalStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: textPadding, left: bulletPointLeftPadding),
                    child: Text(String.fromCharCode(0x2022) + "	use any Documentation to support your permitted use of the App and the Service;", style: normalStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: textPadding, left: bulletPointLeftPadding),
                    child: Text(String.fromCharCode(0x2022) + "	provided you comply with the licences restrictions set out in this User Agreement, make up one copy of the App and the Documentation for back-up purposes provided that the reproduce the App in its original form and with all proprietary notices on the back up copy; and", style: normalStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: textPadding, left: bulletPointLeftPadding),
                    child: Text(String.fromCharCode(0x2022) + "	receive and use any free supplementary software code or update of the App incorporating “patches” and corrections of errors as We may provide to you.", style: normalStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: textPadding),
                    child: Text("You must be 18 to accept these terms and download the app", style: titleStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: textPadding),
                    child: Text("You must be 18 or over to accept these terms and download the App.", style: normalStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: textPadding),
                    child: Text("You may not transfer the App to someone else", style: titleStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: textPadding),
                    child: Text("We are giving you personally the right to use the App and the Service as set out above you may not otherwise transfer the App or the Service to someone else, whether for money, for anything else or for free. If you sell any device on which the App is installed, you must remove the App from it.", style: normalStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: textPadding),
                    child: Text("Changes to these terms", style: titleStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: textPadding),
                    child: Text("We may need to change these terms to reflect changes in law or best practice or to deal with additional features which We introduce, including but not limited to charging fees for the App, or changing the appearance or functionality. ", style: normalStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: textPadding),
                    child: Text("We will give you notice of any change by notifying you of a change when you next start the App.", style: normalStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: textPadding),
                    child: Text("If you do not accept the notified changes you will not be permitted to continue to use the App and the Service. We may terminate this User Agreement and cease your use  of the App and Services at any time.", style: normalStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: textPadding),
                    child: Text("Update to the App and changes to the Service", style: titleStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: textPadding),
                    child: Text("From time to time We may automatically update the App and change the Service to improve performance, enhance functionality, reflect changes to the operating system or address security issues. Alternatively We may ask you to update the App for these reasons.", style: normalStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: textPadding),
                    child: Text("If you choose not to install such updates or if you opt out of automatic updates you may not be able to continue using the App and the Services.", style: normalStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: textPadding),
                    child: Text("If someone else owns the phone or device you are using", style: titleStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: textPadding),
                    child: Text("If you download or stream the App onto any phone or other device not owned by you, you must have the owner's permission to do so. You will be responsible for complying with these terms, whether or not you own the phone or other device.", style: normalStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: textPadding),
                    child: Text("We may collect technical data about your device", style: titleStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: textPadding),
                    child: Text("By using the App or any of the Services, you agree to Us collecting and using technical information about the devices you use the App on and related software, hardware and peripherals to improve Our products and to provide any Services to you.", style: normalStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: textPadding),
                    child: Text("We may collect location data (but you can turn location services off)", style: titleStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: textPadding),
                    child: Text("Certain Services may make use of location data sent from your devices. You can turn off this functionality at any time by turning off the location services settings for the App on the device. If you use these Services, you consent to Us and Our affiliates' and licensees' transmission, collection, retention, maintenance, processing and use of your location data and queries to provide and improve location-based and road traffic-based products and services.", style: normalStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: textPadding),
                    child: Text("We are not responsible for other websites you link to", style: titleStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: textPadding),
                    child: Text("The App or any Service may contain links to other independent websites which are not provided by Us. Such independent sites are not under Our control, and We are not responsible for and have not checked and approved their content or their privacy policies (if any).", style: normalStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: textPadding),
                    child: Text("You will need to make your own independent judgement about whether to use any such independent sites, including whether to buy any products or services offered by them.", style: normalStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: textPadding),
                    child: Text("Licence restrictions", style: titleStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: textPadding),
                    child: Text("You agree that you will:", style: normalStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: textPadding, left: bulletPointLeftPadding),
                    child: Text(String.fromCharCode(0x2022) + "	not rent, lease, sub-license, loan, provide, or otherwise make available, the App or the Services in any form, in whole or in part to any person without prior written consent from Us;", style: normalStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: textPadding, left: bulletPointLeftPadding),
                    child: Text(String.fromCharCode(0x2022) + "	not copy the App, Documentation or Services, except as part of the normal use of the App or where it is necessary for the purpose of back-up or operational security;", style: normalStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: textPadding, left: bulletPointLeftPadding),
                    child: Text(String.fromCharCode(0x2022) + "	not translate, merge, adapt, vary, alter or modify, the whole or any part of the App, Documentation or Services nor permit the App or the Services or any part of them to be combined with, or become incorporated in, any other programs, except as necessary to use the App and the Services on devices as permitted in these terms;", style: normalStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: textPadding, left: bulletPointLeftPadding),
                    child: Text(String.fromCharCode(0x2022) + "	not disassemble, de-compile, reverse engineer or create derivative works based on the whole or any part of the App or the Services nor attempt to do any such things, except to the extent that (by virtue of sections 50B and 296A of the Copyright, Designs and Patents Act 1988) such actions cannot be prohibited because they are necessary to decompile the App to obtain the information necessary to create an independent program that can be operated with the App or with another program (Permitted Objective), and provided that the information obtained by you during such activities:", style: normalStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: textPadding, left: bulletPointLeftPadding*3),
                    child: Text(String.fromCharCode(0x2022) + "	is not disclosed or communicated without the Licensor's prior written consent to any third party to whom it is not necessary to disclose or communicate it in order to achieve the Permitted Objective; and", style: normalStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: textPadding, left: bulletPointLeftPadding*3),
                    child: Text(String.fromCharCode(0x2022) + "	is not used to create any software that is substantially similar in its expression to the App;", style: normalStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: textPadding, left: bulletPointLeftPadding*3),
                    child: Text(String.fromCharCode(0x2022) + "	is kept secure; and", style: normalStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: textPadding, left: bulletPointLeftPadding*3),
                    child: Text(String.fromCharCode(0x2022) + "	is used only for the Permitted Objective;", style: normalStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: textPadding, left: bulletPointLeftPadding),
                    child: Text(String.fromCharCode(0x2022) + "	comply with all applicable technology control or export laws and regulations that apply to the technology used or supported by the App or any Service.", style: normalStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: textPadding),
                    child: Text("Acceptable use restrictions", style: titleStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: textPadding),
                    child: Text("You must:", style: normalStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: textPadding, left: bulletPointLeftPadding),
                    child: Text(String.fromCharCode(0x2022) + "	not use the App or any Service in any unlawful manner, for any unlawful purpose, or in any manner inconsistent with these terms, or act fraudulently or maliciously, for example, by hacking into or inserting malicious code, such as viruses, or harmful data, into the App, any Service or any operating system;", style: normalStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: textPadding, left: bulletPointLeftPadding),
                    child: Text(String.fromCharCode(0x2022) + "	not infringe Our intellectual property rights or those of any third party in relation to your use of the App or any Service, including by the submission of any material (to the extent that such use is not licensed by these terms);", style: normalStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: textPadding, left: bulletPointLeftPadding),
                    child: Text(String.fromCharCode(0x2022) + "	not transmit any material that is defamatory, offensive or otherwise objectionable in relation to your use of the App or any Service;", style: normalStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: textPadding, left: bulletPointLeftPadding),
                    child: Text(String.fromCharCode(0x2022) + "	not use the App or any Service in a way that could damage, disable, overburden, impair or compromise Our systems or security or interfere with other users; and", style: normalStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: textPadding, left: bulletPointLeftPadding),
                    child: Text(String.fromCharCode(0x2022) + "	not collect or harvest any information or data from any Service or Our systems or attempt to decipher any transmissions to or from the servers running any Service.", style: normalStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: textPadding),
                    child: Text("Intellectual property rights", style: titleStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: textPadding),
                    child: Text("All intellectual property rights in the App, the Documentation and the Services throughout the world belong to Us (or Our licensors) and the rights in the App and the Services are licensed (not sold) to you. You have no intellectual property rights in, or to, the App, the Documentation or the Services other than the right to use them in accordance with these terms.", style: normalStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: textPadding),
                    child: Text("All intellectual property rights in photos, profiles, audio and video clips (Content) that you display or post through the App and the Services shall belong to you. By uploading any Content you shall grant to Us, and any users of the App and Services who you choose to share the Content with, a non-exclusive, fully paid and royalty free, worldwide, sublicenseable, transferable licence to use, modify, delete, add to, publicly display and reproduce that Content.", style: normalStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: textPadding),
                    child: Text("Our responsibility for loss or damage suffered by you", style: titleStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: textPadding),
                    child: Text("We are responsible to you for foreseeable loss and damage caused by Us. If We fail to comply with these terms, We are responsible for loss or damage you suffer that is a foreseeable result of Our breaking these terms or Our failing to use reasonable care and skill, but We are not responsible for any loss or damage that is not foreseeable. Loss or damage is foreseeable if either it is obvious that it will happen or if, at the time you accepted these terms, both We and you knew it might happen.", style: normalStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: textPadding),
                    child: Text("We do not exclude or limit in any way Our liability to you where it would be unlawful to do so. This includes liability for death or personal injury caused by Our negligence or the negligence of Our employees, agents or subcontractors or for fraud or fraudulent misrepresentation.", style: normalStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: textPadding),
                    child: Text("We do not exclude or limit in any way Our liability to you where it would be unlawful to do so. This includes liability for death or personal injury caused by Our negligence or the negligence of Our employees, agents or subcontractors or for fraud or fraudulent misrepresentation.", style: normalStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: textPadding),
                    child: Text("When We are liable for damage to your property. If defective digital content that We have supplied damages a device or digital content belonging to you, We will either repair the damage or pay you compensation. However, We will not be liable for damage that you could have avoided by following Our advice to apply an update offered to you free of charge or for damage that was caused by you failing to correctly follow installation instructions or to have in place the minimum system requirements advised by Us.", style: normalStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: textPadding),
                    child: Text("We are not liable for business losses. The App is for domestic and private use. If you use the App for any commercial, business or resale purpose We will have no liability to you for any loss of profit, loss of business, business interruption, or loss of business opportunity.", style: normalStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: textPadding),
                    child: Text("Limitations to the App and the Services. The App and the Services are provided for general information and entertainment purposes only. They do not offer advice on which you should rely. You must obtain professional or specialist advice before taking, or refraining from, any action on the basis of information obtained from the App or the Service. Although We make reasonable efforts to update the information provided by the App and the Service, We make no representations, warranties or guarantees, whether express or implied, that such information is accurate, complete or up to date.", style: normalStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: textPadding),
                    child: Text("Please back-up content and data used with the App. We recommend that you back up any content and data used in connection with the App, to protect yourself in case of problems with the App or the Service.", style: normalStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: textPadding),
                    child: Text("Check that the App and the Services are suitable for you. The App and the Services have not been developed to meet your individual requirements. Please check that the facilities and functions of the App and the Services (as described on the appstore site and in the Documentation) meet your requirements.", style: normalStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: textPadding),
                    child: Text("We are not responsible for events outside Our control. If Our provision of the Services or support for the App or the Services is delayed by an event outside Our control then We will contact you as soon as possible to let you know and We will take steps to minimise the effect of the delay. Provided We do this We will not be liable for delays caused by the event  but if there is a risk of substantial delay you may contact Us to end your contract with Us and receive a refund for any Services you have paid for but not received.", style: normalStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: textPadding),
                    child: Text("We may end your rights to use the App and the Services if you break these terms", style: titleStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: textPadding),
                    child: Text("We may end your rights to use the App and Services at any time by contacting you if you have broken these terms in a serious way. If what you have done can be put right We will give you a reasonable opportunity to do so.", style: normalStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: textPadding),
                    child: Text("If We end your rights to use the App and Services:", style: normalStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: textPadding, left: bulletPointLeftPadding),
                    child: Text(String.fromCharCode(0x2022) + "	You must stop all activities authorised by these terms, including your use of the App and any Services.", style: normalStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: textPadding, left: bulletPointLeftPadding),
                    child: Text(String.fromCharCode(0x2022) + "	You must delete or remove the App from all devices in your possession and immediately destroy all copies of the App which you have and confirm to Us that you have done this.", style: normalStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: textPadding, left: bulletPointLeftPadding),
                    child: Text(String.fromCharCode(0x2022) + "	We may remotely access your devices and remove the App from them and cease providing you with access to the Services.", style: normalStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: textPadding),
                    child: Text("We may transfer this agreement to someone else", style: titleStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: textPadding),
                    child: Text("We may transfer Our rights and obligations under these terms to another organisation. We will always tell you in writing if this happens and We will ensure that the transfer will not affect your rights under the contract.", style: normalStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: textPadding),
                    child: Text("You need Our consent to transfer your rights to someone else", style: titleStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: textPadding),
                    child: Text("You may only transfer your rights or your obligations under these terms to another person if We agree in writing.", style: normalStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: textPadding),
                    child: Text("No rights for third parties", style: titleStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: textPadding),
                    child: Text("This agreement does not give rise to any rights under the Contracts (Rights of Third Parties) Act 1999 to enforce any term of this agreement.", style: normalStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: textPadding),
                    child: Text("If a court finds part of this contract illegal, the rest will continue in force", style: titleStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: textPadding),
                    child: Text("Each of the paragraphs of these terms operates separately. If any court or relevant authority decides that any of them are unlawful, the remaining paragraphs will remain in full force and effect.", style: normalStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: textPadding),
                    child: Text("Even if We delay in enforcing this contract, We can still enforce it later", style: titleStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: textPadding),
                    child: Text("Even if We delay in enforcing this contract, We can still enforce it later. If We do not insist immediately that you do anything you are required to do under these terms, or if We delay in taking steps against you in respect of your breaking this contract, that will not mean that you do not have to do those things and it will not prevent Us taking steps against you at a later date.", style: normalStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: textPadding),
                    child: Text("Which laws apply to this contract and where you may bring legal proceedings", style: titleStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: textPadding),
                    child: Text("These terms are governed by English and Welsh law and you can bring legal proceedings in respect of the products in the English and Welsh courts. If you live in Scotland you can bring legal proceedings in respect of the products in either the Scottish or the English and Welsh courts. If you live in Northern Ireland you can bring legal proceedings in respect of the products in either the Northern Irish or the English and Welsh courts.", style: normalStyle),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
