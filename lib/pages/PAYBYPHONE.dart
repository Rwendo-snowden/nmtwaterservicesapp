import 'dart:convert';

import 'package:azampay/azampay.dart';
import 'package:flutter/material.dart';

class Paybyphone extends StatefulWidget {
  const Paybyphone({super.key});

  @override
  State<Paybyphone> createState() => _PaybyphoneState();
}

// get these credentials from the azampay developers account
var azampay = AzamPay(
    appName: 'AIED',
    clientId: 'e526a508-9cc4-4509-87eb-3bfa6a1ef48e',
    clientSecret:
        'GLZNBgYJHSi3Tbueyhubv5Qz9CwvOT9btzV7O8Nh2NsRvP/XTfBFaPheQF6DrEYv10SRHNUdT45cCDREKHYvA781yLh2jDSlyHhv879mKHWxtP8WFxNrt49NqhS+MjALY/KfCz7ro9bdJZrpceO3zuoaPR2ZI4WdPZljDXj++yDKn9Anli/CTFwrf+ZcbmhHcjIWQOOo93ecYSoWUixtLFCiiZfPvNBGvhMtM+44SdCEZo3YFsX+LEGKo5uh4T5oQiCA5gMdmPx/pUElcU1xKJgx46lfmshMhAixUZig4I3sCESkqOopZcNyOC2FRRVoYu7YvV8KYPREMjWsX7HvZnR9Ij8qKpYtowj53ALeuk5WCQGmL6ouqJy68aF5pvwFs/8RPcaJzWPVpyqXefR9n2x9Bn2okdrarEkD63h33okb49Zca5ZG5zZx4r/onfx89490J8KxqilceSUHQs6jjtcfr5Cb5er1uSZwXcOYlUWVf+FTI0zy6hj0lQQXHbWJgcQ/ycMX+JCn+gsymjZT34Dz0OI5Mq0POBbYd6CIfKroNofuOEq/vDbGA0vUHgPF9eQ/egs8Ez4CqL0Z5tlccaJo64LDZ+pt52/a+VbaOsrsfOtTbCoSUD0HdfeRkvggZREx4KBh8bNnI9CFnOKLTO73j+y1ZUw1u8RRiGQTLjw=');

class _PaybyphoneState extends State<Paybyphone> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              print('Rwendokiba');
              var mobileResponse = await azampay.mobileCheckout(
                  merchantMobileNumber: "0613311958",
                  amount: "1000",
                  currency: "TZS",
                  provider:
                      "Halopesa", // ["Airtel" "Tigo" "Halopesa" "Azampesa"]
                  externalId: "12",
                  additionalProperties: {});

              print(json.decode(mobileResponse.body));

// successful mobile checkout response (you can now see a push USSD on your phone)
            },
            child: Text('Pay'),
          ),
        ],
      ),
    );
  }
}
