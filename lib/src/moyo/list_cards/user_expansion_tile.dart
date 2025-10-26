import 'package:flutterprovider/flutterprovider.dart';

class UserExpansionTile extends StatelessWidget {
  final String dp;
  final String title;
  final String subtitle;

  const UserExpansionTile({
    super.key,
    required this.dp,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: ExpansionTile(
        backgroundColor: Colors.white,
        collapsedBackgroundColor: Colors.white,
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        leading: Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
          height: 45,
          width: 45,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CachedNetworkImage(
                imageUrl: dp,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    Image.asset('packages/flutterprovider/assets/images/aaspas_shopPlaceholder.png'),
                errorWidget: (context, url, error) =>
                    Image.asset('packages/flutterprovider/assets/images/aaspas_shopPlaceholder.png'),
              ),
            ],
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Text(subtitle),
        childrenPadding: const EdgeInsets.all(16),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Choose Service Type',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: MoyoColorBox.black,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MoyoColorBox.moyoOrange,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Instant'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: MoyoColorBox.moyoOrange),
                    padding: EdgeInsets.symmetric(vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Later',
                    style: TextStyle(color: MoyoColorBox.moyoOrange),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
