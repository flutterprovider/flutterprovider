import '../../flutterui.dart';

class UserAddressCard extends StatelessWidget {
  final String? address;
  final String? phone;
  final bool isPrimary;
  final VoidCallback? onPress;

  const UserAddressCard({
    super.key,
    this.address,
    this.phone,
    this.isPrimary = false,
    this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          spacing: 6,
          children: [
            SvgPicture.asset("packages/flutterprovider/assets/icons/moyo_address_card_home_icon.svg"),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                spacing: 10,
                children: [
                  _userAddress(context, address),
                  _userPhone(context, phone),
                  if (isPrimary == true)
                  _primaryStatusChip(context),
                  _editButton(context, onPress),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _userAddress(BuildContext context, String? address) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      child: Text(
        address ?? "No Address",
        textAlign: TextAlign.start,
        maxLines: 5,
        overflow: TextOverflow.ellipsis,
        style: GoogleFonts.roboto(
          textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Color(0xFF7A7A7A),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _userPhone(BuildContext context, String? phone) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        spacing: 10,
        children: [
          Text(
            "Phone :",
            textAlign: TextAlign.start,
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.roboto(
              textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Color(0xFF7A7A7A),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Text(
            phone ?? "No phone",
            textAlign: TextAlign.start,
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.roboto(
              textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Color(0xFF000000),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _editButton(BuildContext context, VoidCallback? onPress) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: InkWell(
        onTap: onPress,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            // color: MoyoColorBox.moyoOrange,
            border: Border.all(color: MoyoColorBox.moyoOrange, width: 1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 8,
            children: [
              Icon(Icons.edit_note_outlined, color: MoyoColorBox.moyoOrange),
              // SvgPicture.asset("packages/flutterprovider/assets/icons/moyo_white_star.svg"),
              Text(
                "Edit",
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.roboto(
                  textStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: MoyoColorBox.moyoOrange,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _primaryStatusChip(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color: Color(0xFF009A00),
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        child: Text(
          "Primary",
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.roboto(
            textStyle: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
            color: Color(0xFFFFFFFF),
          ),
        ),
      ),
    );
  }
}
