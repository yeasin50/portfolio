import 'package:contact/contact.dart';
import 'package:contact/src/presentation/bloc/contact_bloc.dart';
import 'package:flutter/material.dart';
import 'package:effects/effects.dart' as eff;
import 'package:flutter_bloc/flutter_bloc.dart';

@Deprecated("No longer required")
typedef OnSubmitTap = Future<void> Function(ContactRequest req);

/// user can contact me .x. // TODO : ney; Not build for ui keyboard stuffs
class ContactFormPage extends StatelessWidget {
  const ContactFormPage._();

  static eff.RippleRoute route({
    required FractionalOffset animateTO,
    FractionalOffset? animateFrom,
    Duration pushDuration = Durations.medium3,
    Duration? popDuration,
    Color primaryColor = Colors.white,
    required eff.SpherePlasmaData plasmaData,
  }) {
    final route = eff.RippleRoute(
      builder: (context) => ContactFormPage._(),
      center: animateTO,
      popPosition: animateFrom ?? animateTO,
      duration: pushDuration,
      popDuration: popDuration ?? pushDuration,
      color: primaryColor,
    );
    return route;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GetInTouchCubit, GetInTouchState>(
        builder: (context, state) {
          return eff.BackgroundView(
            colors: [Color(0xFF1E2036), Color(0xFF343C59)],
            child: Column(
              children: [
                if (!state.isAlreadySubmited)
                  Align(
                    alignment: Alignment(-1, 0),
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: eff.AnimatedBackButton(
                        onTap: Navigator.of(context).pop,
                        child: Text("back"),
                      ),
                    ),
                  ),
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    switchInCurve: Curves.easeOutCubic,
                    switchOutCurve: Curves.easeInCubic,

                    transitionBuilder: (child, animation) {
                      final slide = Tween<Offset>(
                        begin: const Offset(0, 0.1),
                        end: Offset.zero,
                      ).animate(animation);

                      return FadeTransition(
                        opacity: animation,
                        child: SlideTransition(position: slide, child: child),
                      );
                    },

                    layoutBuilder: (currentChild, previousChildren) {
                      return Stack(
                        alignment: Alignment.center,
                        children: [
                          ...previousChildren,
                          if (currentChild != null) currentChild,
                        ],
                      );
                    },

                    child: state.isAlreadySubmited
                        ? Center(
                            key: const ValueKey("submitted"),
                            child: _SumbitCompleteView(),
                          )
                        : Align(
                            key: const ValueKey("form"),
                            alignment: const Alignment(0, -.3),
                            child: SingleChildScrollView(
                              child: ConstrainedBox(
                                constraints: const BoxConstraints.tightFor(
                                  width: 500,
                                ),
                                child: _NewContactView(),
                              ),
                            ),
                          ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// if user already submitted the form
class _SumbitCompleteView extends StatelessWidget {
  const _SumbitCompleteView();

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      mainAxisSize: MainAxisSize.min,
      children: [
        Center(
          child: eff.ShadowTextEffect(
            text: "Thank you...",
            shadowColor: Colors.white54,
            style: TextStyle(color: Colors.blue, fontSize: 44),
          ),
        ),
        Text(
          "Will get back to you sooooon",
          style: TextTheme.of(context).bodyLarge?.copyWith(color: Colors.white),
        ),
        Padding(
          padding: const EdgeInsets.all(32.0),
          child: eff.AnimatedBackButton(
            onTap: Navigator.of(context).pop,
            child: Text(
              "ok :>",
              style: TextTheme.of(
                context,
              ).bodyMedium?.copyWith(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}

/// form  with bloc, handles submitting new contact form
class _NewContactView extends StatefulWidget {
  const _NewContactView();

  @override
  State<_NewContactView> createState() => _NewContactViewState();
}

class _NewContactViewState extends State<_NewContactView> {
  @override
  void initState() {
    super.initState();
    // helps to clean the prev state
    BlocProvider.of<GetInTouchCubit>(context).update(ContactRequest.empty);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<ContactThemeExt>()!;
    return BlocBuilder<GetInTouchCubit, GetInTouchState>(
      builder: (context, state) {
        final bloc = BlocProvider.of<GetInTouchCubit>(context);
        assert(
          !state.isAlreadySubmited,
          "this page should only handle ongoing form submit",
        );
        return Column(
          children: [
            Center(
              child: eff.ShadowTextEffect(
                text: "Get in touch",
                shadowColor: Colors.white54,
                style: TextStyle(color: Colors.blue, fontSize: 44),
              ),
            ),
            SizedBox(height: 8),
            Column(
              spacing: 2,
              children: [
                Text(
                  "Available for questions, collaboration, and projects.",
                  style: TextTheme.of(
                    context,
                  ).bodyMedium?.copyWith(color: Colors.white),
                ),
                Text(
                  "-Based in Dhaka, Bangladesh",
                  style: TextTheme.of(context).bodyMedium?.copyWith(
                    color: Colors.white70,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
            SizedBox(height: 32),
            Column(
              spacing: 16,
              children: [
                AppTextField(
                  title: "Name",
                  maxLine: 1,
                  onChanged: (v) {
                    bloc.update(bloc.state.req.copyWith(name: v));
                  },
                ), //
                AppTextField(
                  title: "email",
                  maxLine: 1,
                  onChanged: (v) {
                    bloc.update(bloc.state.req.copyWith(email: v));
                  },
                ),
                AppTextField(
                  title: "subject",
                  maxLine: 2,
                  minLines: 1,
                  onChanged: (v) {
                    bloc.update(bloc.state.req.copyWith(subject: v));
                  },
                ), //
                AppTextField(
                  title: "message",
                  minLines: 5,
                  maxLine: 10,
                  hint:
                      "E.g., I’d like to discuss a project.\n\n Available slots (GMT+6):\n- 12 Mar, 10–11 PM\n- 14 Mar, 1–2 PM",
                  onChanged: (v) {
                    bloc.update(bloc.state.req.copyWith(message: v));
                  },
                ),
                if (state.error != null)
                  Text(
                    state.error ?? "ney... failed to submit form",
                    style: TextTheme.of(
                      context,
                    ).bodyMedium?.copyWith(color: Colors.redAccent),
                  ),
                SizedBox(height: 4),
                Align(
                  child: AnimatedSwitcher(
                    duration: Durations.medium3,
                    child: state.isLoading
                        ? CircularProgressIndicator(color: Colors.white70)
                        : ClipRRect(
                            borderRadius: BorderRadiusGeometry.circular(243),
                            child: SizedBox(
                              width: 250,
                              child: eff.TextRevealWithArrow(
                                onTap: !bloc.isValid ? null : bloc.submit,
                                initialAnimationValue: 0,
                                label: "Submit",
                                primaryTextStyle: theme.tldr.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                                hoverTextStyle: theme.tldr.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

// not required on other places so  keeping it here

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    this.hint,
    this.initialValue,
    this.readOnly = false,
    this.onTap,
    this.validator,
    this.decoration,
    this.controller,
    this.onChanged,
    this.title,
    this.description,
    this.obscureText = false,
    this.minLines,
    this.maxLine,
    this.autovalidateMode,
    this.textInputType,
    this.suffixIcon,
    this.prefixIcon,
  });

  final String? hint;
  final String? initialValue;
  final String? title;
  final String? description;
  final bool readOnly;
  final VoidCallback? onTap;
  final InputDecoration? decoration;
  final FormFieldValidator<String>? validator;
  final ValueChanged? onChanged;
  final bool obscureText;
  final TextEditingController? controller;
  final int? minLines;
  final int? maxLine;
  final AutovalidateMode? autovalidateMode;
  final TextInputType? textInputType;

  final Widget? suffixIcon;
  final Widget? prefixIcon;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final border = OutlineInputBorder(borderRadius: BorderRadius.circular(8));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      spacing: 8,
      children: [
        if ((widget.title ?? "").isNotEmpty)
          Text(
            widget.title!,
            style: textTheme.titleMedium?.copyWith(color: Colors.white70),
          ),
        TextFormField(
          initialValue: widget.initialValue,
          onTap: widget.onTap,
          readOnly: widget.readOnly,
          controller: widget.controller,
          validator: widget.validator,
          onChanged: widget.onChanged,
          obscureText: widget.obscureText,
          minLines: widget.minLines,
          maxLines: widget.maxLine,
          autovalidateMode: widget.autovalidateMode,
          keyboardType: widget.textInputType,
          style: TextStyle(color: Colors.white),
          decoration:
              widget.decoration?.copyWith(hintText: widget.hint) ??
              InputDecoration(
                suffixIcon: widget.suffixIcon,
                prefixIcon: widget.prefixIcon,
                hintText: widget.hint,
                hintStyle: textTheme.titleSmall?.copyWith(
                  color: Colors.white60,
                ),
                enabledBorder: border.copyWith(
                  borderSide: BorderSide(color: Colors.white12),
                ),
                focusedBorder: border.copyWith(
                  borderSide: BorderSide(
                    color: Colors.blueAccent.withAlpha(200),
                  ),
                ),
                border: border.copyWith(
                  borderSide: BorderSide(color: Colors.white12),
                ),
              ),
        ),
        if (widget.description != null)
          Text(
            widget.description!,
            style: textTheme.bodyMedium?.copyWith(color: Colors.grey),
          ),
      ],
    );
  }
}
