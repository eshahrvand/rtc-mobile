import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rtc_mobile/config/config.dart';
import 'package:rtc_mobile/generated/l10n.dart';
import 'package:rtc_mobile/ui/router/app_route.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';
import 'package:rtc_mobile/ui/widget/rtc_appbar.dart';
import 'package:rtc_mobile/ui/widget/rtc_divider.dart';
import 'package:rtc_mobile/ui/widget/rtc_image.dart';
import 'bloc/wallet_cubit.dart';
import 'bloc/wallet_state.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WalletCubit()..init(),
      child: const _WalletView(),
    );
  }
}

class _WalletView extends StatelessWidget {
  const _WalletView();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: RtcAppBar(
        title: S.current.wallet,
        onBack: () => context.pop(),
        backIconPath: '$baseImage/angle-right.svg',
      ),
      body: BlocBuilder<WalletCubit, WalletState>(
        builder: (context, state) {
          if (state.status == WalletRequestStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.walletSummary == null) return const SizedBox.shrink();

          final summary = state.walletSummary!;

          return Column(
            children: [
              _buildHeader(context, summary),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(24),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 16, left: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                S.current.myPockets,
                                style: theme.labelLarge!.copyWith(
                                  color: AppColors.grayPalette.shade900,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                S.current.pocketsCount(summary.pockets.length),
                                style: theme.bodyLarge!.copyWith(
                                  color: AppColors.grayPalette.shade700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Expanded(
                          child: ListView.separated(
                            itemCount: summary.pockets.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 12),
                            itemBuilder: (context, index) {
                              final pocket = summary.pockets[index];
                              return _PocketCard(
                                pocket: pocket,
                                onTap: () {
                                  context.read<WalletCubit>().selectPocket(
                                    pocket,
                                  );
                                  context.push(
                                    AppRoutes.transactionList,
                                    extra: context.read<WalletCubit>(),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context, dynamic summary) {
    var theme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 25),
      decoration: BoxDecoration(
        boxShadow: AppColors.mediumShadow,
        gradient: const LinearGradient(
          colors: [Color(0xFF194185), Color(0xFF1570EF)],
          begin: Alignment(-0.9, 0.8), // Approx 15deg
          end: Alignment(0.9, -0.8),
          stops: [0.2961, 1.1713],
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                spacing: 4,
                children: [
                  RtcImage(
                    image: '$baseImage/wallet_detail.svg',
                    width: 24,
                    height: 24,
                    color: Colors.white,
                  ),
                  Text(
                    S.current.totalBalance,
                    style: theme.bodyLarge!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Row(
                spacing: 2,
                children: [
                  Text(
                    summary.totalBalance,
                    style: theme.titleLarge!.copyWith(color: Colors.white),
                  ),
                  RtcImage(
                    image: "$baseImage/toman_white.svg",
                    width: 16,
                    height: 16,
                    boxFit: BoxFit.fill,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 43),
          Row(
            children: [
              Expanded(
                child: _HeaderInfoItem(
                  label: S.current.remainingCredit,
                  value: summary.remainingCredit,
                ),
              ),
              Container(
                width: 1,
                height: 32,
                color: Colors.white.withOpacity(0.2),
              ),
              Expanded(
                child: _HeaderInfoItem(
                  label: S.current.totalCredit,
                  value: summary.totalCredit,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeaderInfoItem extends StatelessWidget {
  final String label;
  final String value;

  const _HeaderInfoItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return Column(
      children: [
        Text(label, style: theme.bodyMedium!.copyWith(color: Colors.white)),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 4,
          children: [
            Text(
              value,
              style: theme.titleSmall!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            RtcImage(
              image: "$baseImage/toman_white.svg",
              width: 16,
              height: 16,
              boxFit: BoxFit.fill,
            ),
          ],
        ),
      ],
    );
  }
}

class _PocketCard extends StatelessWidget {
  final dynamic pocket;
  final VoidCallback onTap;

  const _PocketCard({required this.pocket, required this.onTap});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return InkWell(
      onTap: onTap,

      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: AppColors.primaryShadow,
        ),
        height: 110,
        child: Column(
          children: [
            Row(
              children: [
                RtcImage(
                  image: pocket.logoPath,
                  width: 44,
                  height: 44,
                  boxFit: BoxFit.fill,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    spacing: 2,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        pocket.bankName,
                        style: theme.bodyMedium!.copyWith(
                          color: AppColors.grayPalette.shade900,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            pocket.planName,
                            style: theme.labelLarge!.copyWith(
                              color: AppColors.grayPalette.shade900,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          RtcImage(
                            image: '$baseImage/angle-left.svg',
                            width: 20,
                            height: 20,
                            color: AppColors.grayPalette.shade400,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(right: 52),
              child: const RtcDivider(isDashed: false),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 52),
                  child: Text(
                    S.current.balance,
                    style: theme.bodyMedium!.copyWith(
                      color: AppColors.grayPalette.shade700,
                    ),
                  ),
                ),
                Row(
                  spacing: 4,
                  children: [
                    Text(
                      pocket.balance,
                      style: theme.labelMedium!.copyWith(
                        color: AppColors.grayPalette.shade900,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    RtcImage(
                      image: "$baseImage/toman.svg",
                      width: 16,
                      height: 16,
                      boxFit: BoxFit.fill,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
