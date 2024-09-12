class OnboardingContents {
  final String title;
  final String image;
  final String desc;

  OnboardingContents({
    required this.title,
    required this.image,
    required this.desc,
  });
}

List<OnboardingContents> contents = [
  OnboardingContents(
    title: "Free installation setup",
    image: "assets/images/onboarding.png",
    desc: "No need to pay for furniture assembly. We will install your furniture for free.",
  ),
  OnboardingContents(
    title: "Flexible upgrades",
    image: "assets/images/onboardingtwo.png",
    desc:
    "Upgrade your Product with new products after 15 Days of use for free",
  ),
  OnboardingContents(
    title: "Free installation setup",
    image: "assets/images/onboardingthree.png",
    desc:
    "Upgrade your Product with new products after 15 Days of use for free"
  ),
];
