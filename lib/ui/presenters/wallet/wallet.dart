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
                    borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              S.current.myPockets,
                              style: theme.titleMedium!.copyWith(
                                color: AppColors.grayPalette.shade900,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              S.current.pocketsCount(summary.pockets.length),
                              style: theme.bodyMedium!.copyWith(
                                color: AppColors.grayPalette.shade600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Expanded(
                          child: ListView.separated(
                            itemCount: summary.pockets.length,
                            separatorBuilder: (context, index) => const SizedBox(height: 12),
                            itemBuilder: (context, index) {
                              final pocket = summary.pockets[index];
                              return _PocketCard(
                                pocket: pocket,
                                onTap: () {
                                  context.read<WalletCubit>().selectPocket(pocket);
                                  context.push(AppRoutes.transactionList, extra: context.read<WalletCubit>());
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
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 40),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.brandPalette.shade600,
            AppColors.brandPalette.shade700,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
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
                  Text(
                    summary.totalBalance,
                    style: theme.headlineLarge!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    S.current.toman,
                    style: theme.bodySmall!.copyWith(color: Colors.white),
                  ),
                ],
              ),
              Row(
                spacing: 8,
                children: [
                  Text(
                    S.current.totalBalance,
                    style: theme.titleMedium!.copyWith(color: Colors.white),
                  ),
                  RtcImage(
                    image: '$baseImage/wallet.svg',
                    width: 24,
                    height: 24,
                    color: Colors.white,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 32),
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
        Text(
          label,
          style: theme.bodyMedium!.copyWith(color: Colors.white.withOpacity(0.8)),
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 4,
          children: [
            Text(
              value,
              style: theme.titleMedium!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              S.current.toman,
              style: theme.bodySmall!.copyWith(color: Colors.white),
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
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.grayPalette.shade200),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Row(
              children: [
                RtcImage(
                  image: '$baseImage/angle-left.svg',
                  width: 20,
                  height: 20,
                  color: AppColors.grayPalette.shade400,
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      pocket.bankName,
                      style: theme.bodyMedium!.copyWith(color: AppColors.grayPalette.shade600),
                    ),
                    Text(
                      pocket.planName,
                      style: theme.titleMedium!.copyWith(
                        color: AppColors.grayPalette.shade900,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 12),
                Image.asset(
                  pocket.logoPath,
                  width: 40,
                  height: 40,
                ),
              ],
            ),
            const SizedBox(height: 12),
            const RtcDivider(isDashed: true),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  spacing: 4,
                  children: [
                    Text(
                      pocket.balance,
                      style: theme.titleMedium!.copyWith(
                        color: AppColors.grayPalette.shade900,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      S.current.toman,
                      style: theme.bodySmall!.copyWith(color: AppColors.grayPalette.shade700),
                    ),
                  ],
                ),
                Text(
                  S.current.balance,
                  style: theme.bodyMedium!.copyWith(color: AppColors.grayPalette.shade600),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
