import 'package:flutter/material.dart';

class TNC extends StatelessWidget {
  // const TNC({ Key? key }) : super(key: key);

  Widget text(String text, bool bold, double size) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: TextStyle(
            fontSize: size,
            fontWeight: bold ? FontWeight.bold : FontWeight.w300),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Terms and conditions',
                    style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Rowdies'),
                  ),
                ),
                text(
                    'These terms and conditions outline the rules and regulations for the use ofYaarhelp application .',
                    true,
                    18),
                text(
                    'By accessing this application we assume you accept these terms and conditions in full.',
                    false,
                    16),
                text(
                    'The following terminology applies to these Terms and Conditions, Privacy Statement and Disclaimer Notice, and any or all Agreements: “Client”, “You” and “Your” refers to you, the person accessing this website and accepting the Company’s terms and conditions. “The Company”, “Ourselves”, “We”, “Our” and “Us”, refers to our Company. “Party”, “Parties”, or “Us”, refers to both the Client and ourselves, or either the Client or ourselves. All terms refer to the offer, acceptance, and consideration of payment necessary to undertake the process of our assistance to the Client in the most appropriate manner, whether by formal meetings of a fixed duration or any other means, for the express purpose of meeting the Client’s needs in respect of the provision of the Company’s stated services/products, in accordance with and subject to, prevailing law of India. Any use of the above terminology or other words in the singular, plural, capitalization, and/or he/she or they, are taken as interchangeable and therefore as referring to same.',
                    false,
                    16),
                text('ONLINE HELP (TERMS & CONDITIONS)', true, 18),
                text(
                    '1. Do not give money directly to anyone except the platform. in that case of giving money directly to anyone else except the platform, the company  will not be responsible for that.',
                    false,
                    16),
                text('2.  Platform charges 20% commission on online works.',
                    false, 16),
                text(
                    '3. company or website will pay the helper/employee after the work is done within 12 hours.',
                    false,
                    16),
                text('OFFLINE HELP (TERMS & CONDITIONS)', true, 18),
                text(
                    '1. Do not give money directly to anyone except the platform. in that case of giving money directly to anyone else except the platform, the company  will not be responsible for that',
                    false,
                    16),
                text('2. platform charges 20% commission on offline works.',
                    false, 16),
                text(
                    '3. for the helper/employee he/she needs to give one of his ID proof before working for the person who hired the helper.',
                    false,
                    16),
                text(
                    'helper/employee should be polite in behavior while working for the person who hired them.',
                    false,
                    16),
                text(
                    'helper/employee will be immediately blocked by the platform in case of any wrong behavior with the person who hires them. the helper/employee will not be able to work further with the platform.',
                    false,
                    16),
                text(
                    'Company  will pay the helper/employee after the work is done within 12 hours',
                    false,
                    16),
                text('LEARN ENGLISH (TERMS & CONDITIONS)', true, 18),
                text(
                    '1. Do not give money directly to anyone except the platform. in that case of giving money directly to anyone else except the platform, the company  will not be responsible for that.',
                    false,
                    16),
                text(
                    'Platform charges 20% commission on every student from the tutor.',
                    false,
                    16),
                text(
                    'Tutor/learner should be polite in behavior while teaching/learning.',
                    false,
                    16),
                text(
                    'Any abuse will not be tolerated. Person’s ID will be immediately blocked by the platform in case of any violence',
                    false,
                    16),
                text(
                    'company  will pay the tutor after the session is done within 12 hours.',
                    false,
                    16),
                text('PAYMENTS AND REFUNDS', true, 18),
                text('1. Payment mode will be UPI / Debit card / Credit card',
                    false, 16),
                text(
                    '2. Refund on any harm will be directly initiated to the beneficiary within 12 hours after the payment given.',
                    false,
                    16),
                text(
                    'If the person who posted for the help/work is canceled and payment is deducted from the account, in that case, payment will be refunded to the poster within 12 hours.',
                    false,
                    16),
                text('Cookies', true, 20),
                text(
                    'We employ the use of cookies. By using Yaarhelp application you consent to the use of cookies in accordance with Yaarhelp’s privacy policy.',
                    false,
                    16),
                text(
                    'Most modern-day interactive applications use cookies to enable us to retrieve user details for each visit. Cookies are used in some areas of our site to enable the functionality of this area and ease of use for those people visiting. Some of our affiliate/advertising partners may also use cookies',
                    false,
                    16),
                text('License', true, 20),
                text(
                    'Unless otherwise stated, Yaarhelp and/or its licensors own the intellectual property rights for all material on Yaarhelp. All intellectual property rights are reserved. You may view and/or print pages from https://yaarhelp.com/ for your own personal use subject to restrictions set in these terms and conditions.',
                    true,
                    16),
                text('You must not:', true, 16),
                text('1. Republish material from https://yaarhelp.com/', false,
                    16),
                text(
                    '2. Sell, rent, or sub-license material from https://yaarhelp.com/',
                    false,
                    16),
                text(
                    '3. Reproduce, duplicate or copy material from https://yaarhelp.com/',
                    false,
                    16),
                text(
                    '4. Redistribute content from yaarhelp (unless content is specifically made for redistribution).',
                    false,
                    16),
                text('Hyperlinking to our Content', true, 20),
                text(
                    '1. The following organizations may link to our Web site without prior written approval:',
                    true,
                    16),
                text('1. Government agencies;', false, 16),
                text('2. Search engines;', false, 16),
                text('3. News organizations;', false, 16),
                text(
                    '4. Online directory distributors when they list us in the directory may link to our Web site in the same manner as they hyperlink to the Web sites of other listed businesses; and',
                    false,
                    16),
                text(
                    '5. Systemwide Accredited Businesses except soliciting non-profit organizations, charity shopping malls, and charity fundraising groups which may not hyperlink to our Web site.',
                    false,
                    16),
                text(
                    '2. These organizations may link to our home page, to publications or to other Web site information so long as the link: (a) is not in any way misleading; (b) does not falsely imply sponsorship, endorsement or approval of the linking party and its products or services; and (c) fits within the context of the linking party\'s site.',
                    true,
                    16),
                text(
                    '3 We may consider and approve in our sole discretion other link requests from the following types of organizations:',
                    true,
                    16),
                text(
                    '1. commonly-known consumer and/or business information sources such as Chambers of Commerce, American Automobile Association, AARP and Consumers Union;',
                    false,
                    16),
                text('2. dot.com community sites;', false, 16),
                text(
                    '3. Associations or other groups representing charities, including charity giving sites,',
                    false,
                    16),
                text('4. online directory distributors;', false, 16),
                text('5. internet portals;', false, 16),
                text(
                    '6. Acounting, law and consulting firms whose primary clients are businesses; and',
                    false,
                    16),
                text('7. educational institutions and trade associations.',
                    false, 16),
                text(
                    'We will approve link requests from these organizations if we determine that: (a) the link would not reflect unfavorably on us or our accredited businesses (for example, trade associations or other organizations representing inherently suspect types of business, such as work-at-home opportunities, shall not be allowed to link); (b)the organization does not have an unsatisfactory record with us; (c) the benefit to us from the visibility associated with the hyperlink outweighs the absence of ; and (d) where the link is in the context of general resource information or is otherwise consistent with editorial content in a newsletter or similar product furthering the mission of the organization.',
                    false,
                    16),
                text(
                    'These organizations may link to our home page, to publications or to other Web site information so long as the link: (a) is not in any way misleading; (b) does not falsely imply sponsorship, endorsement or approval of the linking party and it products or services; and (c) fits within the context of the linking party\'s site.',
                    false,
                    16),
                text(
                    'If you are among the organizations listed in paragraph 2 above and are interested in linking to our website, you must notify us by sending an e-mail to infoyaarhelp@gmail.com  Please include your name, your organization name, contact information (such as a phone number and/or e-mail address) as well as the URL of your site, a list of any URLs from which you intend to link to our Web site, and a list of the URL(s) on our site to which you would like to link. Allow 2-3 weeks for a response.',
                    false,
                    16),
                text(
                    'No use of yaarhelp logo or other artwork will be allowed for linking absent a trademark license agreement',
                    false,
                    16),
                text('Reservation of Right', true, 20),
                text(
                    'We reserve the right at any time and in its sole discretion to request that you remove all links or any particular link to our platform. You agree to immediately remove all links to our application upon such request. We also reserve the right to amend these terms and conditions and its linking policy at any time. By continuing to link to our Web site, you agree to be bound to and abide by these linking terms and conditions.',
                    false,
                    16),
                text('Content Liability', true, 20),
                text(
                    'We shall have no responsibility or liability for any content appearing on our platform. You agree to indemnify and defend us against all claims arising out of or based upon our Website. No link(s) may appear on any page on our platform or within any context containing content or materials that may be interpreted as libelous, obscene or criminal, or which infringes, otherwise violates, or advocates the infringement or other violation of, any third party rights.',
                    false,
                    16),
                text('Disclaimer', true, 20),
                text(
                    'To the maximum extent permitted by applicable law, we exclude all representations, warranties and conditions relating to our website and the use of this platform (including, without limitation, any warranties implied by law in respect of satisfactory quality, fitness for purpose and/or the use of reasonable care and skill). Nothing in this disclaimer will:',
                    true,
                    16),
                text(
                    '1. limit or exclude our or your liability for death or personal injury resulting from negligence;',
                    false,
                    16),
                text(
                    '2. limit or exclude our or your liability for fraud or fraudulent misrepresentation;',
                    false,
                    16),
                text(
                    '3. limit any of our or your liabilities in any way that is not permitted under applicable law; or',
                    false,
                    16),
                text(
                    '4. exclude any of our or your liabilities that may not be excluded under applicable law.',
                    false,
                    16),
                text(
                    'The limitations and exclusions of liability set out in this Section and elsewhere in this disclaimer: (a) are subject to the preceding paragraph; and (b) govern all liabilities arising under the disclaimer or in relation to the subject matter of this disclaimer, including liabilities arising in contract, in tort (including negligence) and for breach of statutory duty.',
                    false,
                    16),
                text(
                    'To the extent that the website and the information and services on the website are provided free of charge, we will not be liable for any loss or damage of any nature',
                    false,
                    16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
